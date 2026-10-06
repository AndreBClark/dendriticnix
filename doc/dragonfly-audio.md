# Dragonfly Audio: HDA Pin Retasking + PipeWire Playbook

Everything learned configuring the Dell XPS 15 9560 (Realtek **ALC3266**, `hdaudioC0D0`) to: disable internal speaker + internal mic, enable only the combo headset jack, and route all captures through EasyEffects.

## Final working config (`hosts/dragonfly/audio.nix`)

```nix
{
  den.aspects.hardware.hosts.dragonfly.audio.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.alsa-utils   # amixer, speaker-test, alsamixer
        pkgs.alsa-tools   # hda-verb, hdajackretask
      ];

      systemd.services.hda-pin-retask = {
        description = "Retask ALC3266 pins";
        wantedBy = [ "sound.target" ];
        before = [ "sound.target" ];
        path = [ pkgs.alsa-tools pkgs.alsa-utils ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = toString (
            pkgs.writeShellScript "hda-retask" ''
              cd /sys/class/sound/hwC0D0
              echo '0x12 0x411111f0' > user_pin_configs   # internal DMIC off
              # NOTE: 0x17 (speaker) kept alive — its EAPD powers the
              # shared amp the headphone jack needs. Silenced via mute.
              echo '0x18 0x03a19050' > user_pin_configs   # headset mic -> jack
              echo 1 > reconfig
              amixer -c0 set 'Speaker' mute
            ''
          );
        };
      };

      services.pipewire.wireplumber.extraConfig."52-dragonfly-visibility" = {
        "monitor.alsa.rules" = [
          {
            matches = [ { "node.name" = "alsa_output.pci-0000_00_1f.3.analog-stereo"; } ];
            actions.update-props."node.description" = "Headphones";
          }
          {
            matches = [ { "node.name" = "alsa_input.pci-0000_00_1f.3.analog-stereo"; } ];
            actions.update-props."node.description" = "Headset Mic";
          }
        ];
      };
    };

  homeManager = { lib, ... }: {
    xdg.configFile."easyeffects/autoload/input/alsa_input.pci-0000_00_1f.3.analog-stereo:analog-input-headset-mic.json".text =
      builtins.toJSON {
        device = "alsa_input.pci-0000_00_1f.3.analog-stereo";
        profile = "analog-input-headset-mic";
        preset = "NPR";
      };
  };
}
```

## ALC3266 pin map (dragonfly, card0/codec#0)

| Node | Factory Pin Default | Role | Action |
|---|---|---|---|
| `0x21` | `0x03211020` `[Jack] HP Out Ext Left` | headphone jack | **keep** |
| `0x17` | `[Fixed] Speaker Int` + **EAPD** | internal speaker — powers shared amp | keep, `amixer set 'Speaker' mute` |
| `0x12` | `[Fixed] Mic Int`, `Conn = Digital` | internal DMIC | `0x411111f0` |
| `0x18` | `0x411111f0` (unwired, VREF_80 active) | headset mic pin on TRRS jack | retask to `0x03a19050` |
| `0x14`, `0x19`, `0x1a`, `0x1e`, `0x1f` | already `0x411111f0` | unwired spares | leave |

## Lessons learned

### 1. systemd options type-check strings — no globs

`systemd.services.<name>.after` is validated by a `strMatching` type; `"sys-devices-pci0000:00-*.sound-card0.device"` fails evaluation with a cryptic `head` builtin trace from `lib/modules.nix` (`evalOptionValue` → `type.check` per definition). The real error is always at the **bottom** of the trace. Ordering to `sound.target` via `before`/`wantedBy` is sufficient — no `after` needed.

### 2. WirePlumber rules act on nodes/devices, never ports

`monitor.alsa.rules` can only `update-props` on whole `node.name`/`device.name` matches — you cannot disable a single *port*. A headset mic is a port (`analog-input-headset-mic`) on the same `alsa_input.*` node as the internal mic, so `node.disabled` on the input kills both. Port-level selection must happen at the codec layer (pin retask).

- `device.disabled = true` hides the whole card → PipeWire falls back to "Dummy Output".
- `node.description` renames nodes for UIs.
- Exact node names come from `wpctl status` / `pw-dump | grep node.name`; `~regex` prefix is supported.
- `extraConfig` entries become drop-ins in `wireplumber.conf.d` — nested as `extraConfig."<file-name>"."<section>"`.

### 3. Pin retask workflow

Runtime iteration (no rebuild needed — `SND_HDA_RECONFIG` is enabled):

```sh
cd /sys/class/sound/hwC0D0
cat user_pin_configs                                  # see current overrides
echo '0xNN 0xVVVVVVVV' | sudo tee user_pin_configs    # sudo tee, NOT sudo echo >
echo 1 | sudo tee reconfig
systemctl --user restart wireplumber
```

**`sudo echo x > file` fails** — the redirect is opened by your unprivileged shell before sudo runs. Always `sudo tee` or `sudo sh -c`.

Pin default encoding: `0x411111f0` = Port Connectivity N/A = disabled. `0x03a19050` = Jack / Mic / Ext Left. `[Fixed]` = internal; `Misc = NO_PRESENCE` = never detect; `Conn = Digital` = DMIC (internal mics often have no jack pin — look for it).

### 4. `reconfig` is not a full revert

Reverting `user_pin_configs` at runtime doesn't reliably undo a pin that owned amp power — **bisect with full reboots**. On this codec, killing speaker pin `0x17` removed the EAPD that powers the amp feeding headphone pin `0x21`; restoring `0x17` + muting the Speaker mixer was the fix. GPIO fallback if needed:

```sh
sudo hda-verb /dev/snd/hwC0D0 0x01 0x717 0xff   # GPIO enable mask
sudo hda-verb /dev/snd/hwC0D0 0x01 0x715 0xff   # GPIO data
```

(`0x715/0x716/0x717` = SET_GPIO_DATA/DIR/MASK on AFG node `0x01`.)

### 5. Mixer state: sidetone vs playback

`Headset Mic`/`Headphone Mic` **playback** sliders in `amixer` are analog sidetone (mic→headphone loopback) — `[off]` is correct. `Loopback Mixing` is the same idea. Unmute only if you want live mic monitoring.

Mixer state persists across reboots via `hardware.alsa.enablePersistence` → `alsa-store.service` + udev `alsactl restore`. If sound appears then dies after reconfig, `sudo alsactl store` the working state.

### 6. Debugging checklist (order matters)

1. `wpctl status` — are streams `[active]` and linked to the right node? If linked but silent → codec/amp, not routing.
2. `speaker-test -D default -c2` — exercises the full PipeWire→ALSA path. (`hw:0,0` bypasses PipeWire.)
3. `amixer -c0` — check Master/PCM/Headphone switches.
4. `grep -A14 'Node 0x21' /proc/asound/card0/codec#0` — want `Pin-ctls: 0xc0: OUT HP` + `Unsolicited: enabled=1`.
5. `journalctl --boot | rg "Headphone|Mic|hda"` — confirms which pins the driver parsed (`Headset Mic=0x18`).
6. `evtest` on the `HDA Intel PCH Headphone` input device — verifies jack-detect events fire.
7. `pactl` may not be installed — use `wpctl inspect`/`pw-dump` instead. Add `pkgs.pulseaudio` if you want it.
8. `wpctl` object IDs are **unstable across restarts** — inspect by name or re-check IDs.

### 7. Audacity / app routing

- Use **PulseAudio host**, not JACK — JACK-emulated ports need manual `pw-link` wiring; Pulse auto-routes to the default sink/source.
- `services.pipewire.{pulse,alsa,jack}.enable` already provide the emulation layers.

### 8. EasyEffects as default mic

EE doesn't intercept the default device — apps must capture from `easyeffects_source`:

```sh
wpctl set-default easyeffects_source   # persists via WP metadata
```

Signal chain: `Headset Mic → EE sie chain → easyeffects_source → app`.

Preset autoload: `~/.config/easyeffects/autoload/input/<device-name>:<port-name>.json` — EE reads it when the device appears. **Verify exact key schema by letting the EE GUI write the file once**, then bake into `xdg.configFile`. Port name must match exactly (check `wpctl inspect`); drop `:port` from filename to match any port.

Belt-and-braces: enable "Process all input streams" in EE prefs so anything recording the raw device gets linked through EE anyway.

### 9. Misc

- `wpctl clear-settings` clears stale `Default Configured Devices` pointing at deleted nodes.
- `speaker-test` exiting with `Interrupted system call` after Ctrl+C is harmless.
- `kernel: Headphone Mic=0x1a` in dmesg despite a disabled pin default = the codec driver's quirk table, not your config — ignore if the pin is unwired.
- `hdajackretask` (alsa-tools) gives a GUI for the same `user_pin_configs` mechanism.
Notes

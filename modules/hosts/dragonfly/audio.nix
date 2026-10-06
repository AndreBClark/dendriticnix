{
  den.aspects.hardware.hosts.dragonfly.audio = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.alsa-utils
          pkgs.alsa-tools
        ];

        # ── 1. Codec layer (kernel) ────────────────────────────────
        systemd.services.hda-pin-retask = {
          description = "Retask ALC3266 pins + fix mixer";
          wantedBy = [ "sound.target" ];
          before = [ "sound.target" ];
          path = [ pkgs.alsa-utils ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = toString (
              pkgs.writeShellScript "hda-retask" ''
                cd /sys/class/sound/hwC0D0
                echo '0x12 0x411111f0' > user_pin_configs  # kill internal DMIC
                echo '0x18 0x03a19050' > user_pin_configs  # headset mic -> jack
                # 0x17 stays factory — its EAPD powers the shared amp
                echo 1 > reconfig
                amixer -c0 set 'Speaker' mute
              ''
            );
          };
        };

        # ── 2. WirePlumber layer (declarative via extraConfig) ─────
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

        # ── 3. Default source (runtime metadata — needs a unit) ────
        systemd.user.services.easyeffects-default-source = {
          description = "Set EasyEffects virtual source as default input";
          wantedBy = [ "wireplumber.service" ];
          after = [ "wireplumber.service" ];
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.wireplumber}/bin/wpctl set-default easyeffects_source";
            Restart = "on-failure";
            RestartSec = "3s";
            StartLimitBurst = 10;
          };
        };
      };

    homeManager = {
      xdg.configFile = {
        # the preset itself
        "easyeffects/input/NPR.json".source = ../../aspects/hardware/audio/Masc_NPR_VOICE.json;
        # autoload it whenever the headset-mic device appears
        "easyeffects/autoload/input/alsa_input.pci-0000_00_1f.3.analog-stereo:analog-input-headset-mic.json".text =
          builtins.toJSON {
            device = "alsa_input.pci-0000_00_1f.3.analog-stereo";
            profile = "analog-input-headset-mic";
            preset = "NPR";
          };
      };
    };
  };
}

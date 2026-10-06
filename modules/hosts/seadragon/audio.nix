{
  den.aspects.hardware.hosts.seadragon.audio = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.alsa-tools
          pkgs.alsa-utils
          pkgs.pulseaudio
          (pkgs.writeShellScriptBin "audio-toggle-port" ''
            SINK=alsa_output.pci-0000_00_1b.0.analog-stereo
            cur=$(pactl list sinks | sed -n "/Name: $SINK/,/^Sink #/p" | grep -oP 'Active Port: \K\S+')
            [ "$cur" = analog-output-headphones ] \
              && pactl set-sink-port "$SINK" analog-output-speaker \
              || pactl set-sink-port "$SINK" analog-output-headphones
          '')
        ];
        services.pipewire = {
          wireplumber.extraConfig."52-seadragon-visibility" = {

            "monitor.alsa.rules" = [
              # raw analog sink = the port-switching output
              {
                matches = [ { "node.name" = "alsa_output.pci-0000_00_1b.0.analog-stereo"; } ];
                actions.update-props."node.description" = "Speakers / Headphones";
              }
              {
                matches = [ { "node.name" = "alsa_input.pci-0000_00_1b.0.analog-stereo"; } ];
                actions.update-props."node.description" = "Microphone";
              }
              # kill the whole GP102 HDMI audio device (both monitors)
              {
                matches = [ { "device.name" = "alsa_card.pci-0000_02_00.1"; } ];
                actions.update-props."device.disabled" = true;
              }
            ];
          };
        };
        systemd = {
          services = {
            hda-pin-retask = {
              description = "Retask ALC898 rear pin 0x15 as headphone output";
              wantedBy = [ "sound.target" ];
              before = [ "sound.target" ];
              serviceConfig = {
                Type = "oneshot";
                RemainAfterExit = true;
                ExecStart = toString (
                  pkgs.writeShellScript "hda-retask" ''
                    echo '0x14 0x01114010' > user_pin_configs
                    echo '0x15 0x0221401f' > user_pin_configs
                    echo '0x16 0x411111f0' > user_pin_configs
                    echo '0x17 0x411111f0' > user_pin_configs
                    echo '0x1b 0x411111f0' > user_pin_configs
                    echo 'auto_mute = no' > hints
                    echo 1 > reconfig
                  ''
                );
              };
            };
          };
        };

      };
    homeManager =
      { lib, ... }:
      {
        xdg.configFile."niri/binds.kdl".text = lib.mkAfter ''
          binds {
            Mod+F10 hotkey-overlay-title="Toggle Speakers / Headphones" { spawn-sh "audio-toggle-port"; }
          }
        '';
      };
  };
}

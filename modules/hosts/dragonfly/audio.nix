{
  den.aspects.hardware.hosts.dragonfly.audio.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.alsa-utils ];

      # Disable internal speaker + internal mic pins so they can never be used.
      # Pin IDs are laptop-specific — pull them from /proc/asound/card0/codec#0.
      systemd.services.hda-pin-retask = {
        description = "Disable internal HDA pins (speaker, internal mic)";
        before = [ "sound.target" ];
        wantedBy = [ "sound.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = toString (
            pkgs.writeShellScript "hda-retask" ''
              cd /sys/class/sound/hwC0D0
              # kill internals
              echo '0x12 0x411111f0' > user_pin_configs   # internal DMIC
              echo '0x17 0x411111f0' > user_pin_configs   # internal speaker
              # enable headset mic on the combo jack
              echo '0x18 0x03a19050' > user_pin_configs   # Jack, Mic, Ext Left, Detect
              echo 1 > reconfig
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
}

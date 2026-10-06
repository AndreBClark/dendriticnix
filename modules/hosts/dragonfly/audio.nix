{
  den.aspects.hardware.hosts.dragonfly.audio.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.alsa-utils ];

      # Disable internal speaker + internal mic pins so they can never be used.
      # Pin IDs are laptop-specific — pull them from /proc/asound/card0/codec#0.
      systemd.services.hda-pin-retask = {
        description = "Disable internal HDA pins (speaker, internal mic)";
        after = [ "sys-devices-pci0000:00-*.sound-card0.device" ]; # adjust to card path
        before = [ "sound.target" ];
        wantedBy = [ "sound.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = toString (
            pkgs.writeShellScript "hda-retask" ''
              cd /sys/class/sound/hwC0D0
              echo '0x14 0x411111f0' > user_pin_configs
              echo '0x1a 0x411111f0' > user_pin_configs
              echo 1 > reconfig
            ''
          );
        };
      };

      services.pipewire.wireplumber.extraConfig."52-dragonfly-visibility" = {
        "monitor.alsa.rules" = [
          # belt-and-braces: disable internal-mic source node if it survives pin retask
          {
            matches = [ { "node.name" = "~alsa_input.*analog-stereo"; } ];
            actions.update-props."node.disabled" = true;
          }
          # rename the headphone-jack sink to something readable
          {
            matches = [ { "node.name" = "alsa_output.<dev>.analog-stereo"; } ];
            actions.update-props."node.description" = "Headphones";
          }
        ];
      };
    };
}

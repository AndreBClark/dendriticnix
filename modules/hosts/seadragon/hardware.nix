{
  den.aspects.hardware.hosts.seadragon.nixos =
    { pkgs, ... }:
    {
      boot.blacklistedKernelModules = [ "sb_edac" ];
      hardware.display.outputs = {
        "DP-2".mode = "2560x1440@59.951";
        "HDMI-A-1".mode = "d";
      };
      systemd.services.unforce-hdmi = {
        description = "Release forced-off HDMI-A-1 connector";
        after = [ "display-manager.service" ];
        wantedBy = [ "display-manager.service" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.bash}/bin/sh -c 'echo detect > /sys/class/drm/card1-HDMI-A-1/status'";
        };
      };
    };
}

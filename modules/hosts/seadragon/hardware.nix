{
  den.aspects.hardware.hosts.seadragon.nixos = {
    blacklistedKernelModules = [ "sb_edac" ];
    boot.kernelParams = [
      "video=DP-2:2560x1440@60"
      "video=HDMI-A-1:d"
    ];
  };
}

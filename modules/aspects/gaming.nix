{ den, ... }:
{
  den.aspects.gaming = {
    includes = [
      den.aspects.apps.steam
    ];
  };
  nixos = {
    boot = {
      kernelParams = [
        "mitigations=off"
        "nowatchdog"
      ];
      kernel.sysctl = {
        # added to resolve weird wine/proton errors
        "vm.max_map_count" = 1048576;
        "fs.file-max" = 524288;
        "kernel.pid_max" = 4194303;
        "kernel.threads-max" = 524288;
      };
    };
  };
}

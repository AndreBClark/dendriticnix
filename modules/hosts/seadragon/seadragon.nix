{ den, ... }:
{
  den.hosts.x86_64-linux.seadragon = {
    users.andrec = {
      windowManager = "niri";
    };
  };

  den.aspects.seadragon = {
    includes = [
      den.provides.hostname
      den.aspects.hardware.nvidia.provides.nonprime
      den.aspects.hardware.cpu.intel
      den.aspects.hardware.storage.ssd
      den.aspects.display-manager
      den.aspects.vm
    ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          pkgs.git
        ];
        fileSystems."/".device = "/dev/sda1";
        boot.loader.grub.enable = true;
      };
  };
}

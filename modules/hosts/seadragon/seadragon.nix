{ den, ... }:
{
  den.hosts.x86_64-linux.seadragon = {
    users.andrec = {
      windowManager = "niri";
    };
  };

  den.aspects.seadragon = {
    includes = [
      (den.batteries.vm-autologin "andrec")
      den.provides.hostname
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

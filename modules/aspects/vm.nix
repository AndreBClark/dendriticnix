{ den, ... }:
{
  den.aspects.vm = {
    includes = [ (den.batteries.vm-autologin "andrec") ];
    nixos = {
      services.openssh.enable = true;
      services.qemuGuest.enable = true;
      virtualisation.vmVariant = {
        virtualisation = {
          diskImage = null;
          cores = 4;
          memorySize = 4096;
          qemu.options = [
            "-device virtio-vga-gl"
            "-display gtk,gl=on,grab-on-hover=on"
          ];
          forwardPorts = [
            {
              from = "host";
              host.port = 2222;
              guest.port = 22;
            }
          ];
        };
        fileSystems."/".device = "/dev/sda1";
        users.users.andrec.extraGroups = [
          "video"
          "render"
        ];
      };
    };
  };
}

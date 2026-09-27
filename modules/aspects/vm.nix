{ lib, ... }:
{
  # parametric { host } at ASPECT level — returns class contents
  den.aspects.vm = { host, ... }: {
    nixos.virtualisation.vmVariant =
      let
        vmUser = builtins.head (builtins.attrNames host.users);
      in
      {
        services = {
          getty.autologinUser = vmUser; # was services.services.getty — doubled
          openssh.enable = true;
          qemuGuest.enable = true;
          displayManager.autoLogin = {
            enable = true;
            user = vmUser;
          };
        };

        virtualisation = {
          diskImage = null;
          cores = 4;
          memorySize = 8192;
          forwardPorts = [
            {
              from = "host";
              host.port = 2222;
              guest.port = 22;
            }
          ];
          qemu.options = [
            "-device virtio-vga-gl"
            "-display gtk,gl=on,grab-on-hover=on"
          ];
          sharedDirectories.wallpapers = {
            source = "/home/andrec/Pictures";
            target = "/home/andrec/Pictures";
          };
          # wipes the fs.<host> UUID mounts for the VM build only
          fileSystems."/" = lib.mkVMOverride {
            device = "none";
            fsType = "tmpfs";
            options = [ "mode=755" ];
          };
        };

        # top-level option — was nested inside virtualisation
        swapDevices = lib.mkForce [ ];
      };
  };
  den.aspects.vm-grub = { host, ... }: {
    nixos.virtualisation.vmVariant.virtualisation = {
      useBootLoader = true;
      diskImage = "./${host.hostName}-vm-boot.qcow2";
      diskSize = 8192;
    };
  };
}

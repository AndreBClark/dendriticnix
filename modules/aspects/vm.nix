{ lib, ... }:
{
  # parametric { host } at ASPECT level — class functions don't see `host`
  den.aspects.vm = { host, ... }: {
    nixos.virtualisation.vmVariant =
      let
        hasUsers = host.users != { };
        vmUser = if hasUsers then builtins.head (builtins.attrNames host.users) else null;
      in
      {
        services = {
          openssh.enable = true;
          qemuGuest.enable = true;
        }
        // lib.optionalAttrs hasUsers {
          getty.autologinUser = vmUser;
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
        };

        swapDevices = lib.mkForce [ ];
      };
  };

  # grub testbed: static aspect, no host coupling
  den.aspects.vm-grub.nixos = {
    networking.hostName = "vm-grub";
    fileSystems."/" = {
      device = "/dev/vda";
      fsType = "tmpfs";
    };

    boot.loader.grub = {
      efiSupport = lib.mkForce false;
      efiInstallAsRemovable = lib.mkForce false;
    };

    virtualisation.vmVariant.virtualisation = {
      useBootLoader = true; # real disk + grub, not -kernel direct boot
      resolution = {
        x = 1280;
        y = 720;
      };
      diskImage = "./vm-grub.qcow2";
      diskSize = 4096;
      memorySize = 2048;
      cores = 2;
      qemu.options = [ "-display gtk" ];
    };
  };

}

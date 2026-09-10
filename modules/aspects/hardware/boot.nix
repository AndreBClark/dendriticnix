{
  den.aspects.hardware.boot.nixos =
    { lib, pkgs, ... }:
    {
      boot = {
        loader = {
          grub = {
            enable = true;
            efiSupport = true;
            devices = [ "nodev" ];
            configurationLimit = 20;
          };

          efi.canTouchEfiVariables = true;
        };

        kernelPackages = pkgs.linuxPackages_xanmod_stable;
        kernelParams = [
          "console=tty1"
          "tsc=reliable"
          "quiet"
          "systemd.show_status=false"
        ];
        supportedFilesystems = lib.mkForce [
          "btrfs"
          "reiserfs"
          "vfat"
          "f2fs"
          "xfs"
          "ntfs"
          "cifs"
        ];
        tmp.cleanOnBoot = true;
      };
    };
}

{ den, lib, ... }:
{
  den.default.nixos = {
    boot = {
      loader = {
        grub = {
          enable = true;
          efiSupport = true;
          devices = [ "nodev" ];
          efiInstallAsRemovable = true;
          gfxmodeEfi = "1280x720,auto";
        };

        efi.canTouchEfiVariables = false;
      };

      tmp.cleanOnBoot = true;

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
    };
  };

  den.aspects.hardware.boot = {
    includes = [
      den.aspects.theme.grub
    ];
    nixos =
      { pkgs, ... }:
      {
        boot = {
          loader.grub = {
            enable = lib.mkDefault true;
            configurationLimit = 20;
          };
          kernelPackages = pkgs.linuxPackages_xanmod_stable;
        };
      };
  };
}

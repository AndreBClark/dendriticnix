{ den, lib, ... }:
{
  den.default.nixos = {
    boot = {
      consoleLogLevel = 2;
      loader = {
        grub = {
          enable = true;
          efiSupport = true;
          devices = [ "nodev" ];
          efiInstallAsRemovable = true;
          gfxmodeEfi = "1024x768,auto";
          gfxpayloadEfi = "keep";
        };

        efi.canTouchEfiVariables = false;
      };

      tmp.cleanOnBoot = true;

      kernelParams = [
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
          kernelPackages = lib.mkDefault pkgs.linuxPackages_xanmod_stable;
        };
      };
  };
}

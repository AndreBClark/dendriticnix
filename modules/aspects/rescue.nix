{
  den,
  inputs,
  ...
}:
{
  # Host entity → flake.nixosConfigurations.rescue
  den = {
    hosts.x86_64-linux.rescue = {
      users.andrec.aspect = den.aspects.rescue-user;
    };

    aspects.rescue-user.includes = [
      den.provides.primary-user
      den.aspects.minimal-user
    ];

    aspects.rescue = {
      nixos = { lib, pkgs, ... }: {
        imports = [
          "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-base.nix"
        ];

        networking.hostName = "rescue";

        # Neutralize den.default / base-host settings that fight the ISO profile.
        # mkImageMediaOverride (pri 1200) beats mkForce (pri 100) only if used
        # *inside* these modules; to cancel an existing mkForce you must re-force:
        boot = {
          supportedFilesystems = lib.mkForce [
            "zfs"
            "btrfs"
            "ext4"
            "vfat"
            "xfs"
            "ntfs"
          ];
          loader.grub.enable = lib.mkForce false;
          loader.systemd-boot.enable = lib.mkForce false;
        };
        # Rescue niceties
        environment.systemPackages = builtins.attrValues {
          inherit (pkgs)
            git
            pciutils
            usbutils
            smartmontools
            gptfdisk
            parted
            btrfs-progs
            ntfsprogs
            xfsprogs
            dosfstools
            ntfs3g
            rsync
            ddrescue
            testdisk
            cryptsetup
            calamares-nixos
            ;
        };

        services = {
          openssh = {
            enable = true;
            settings.PermitRootLogin = "yes";
          };
          xserver = {
            enable = true;
            desktopManager.xfce = {
              enable = true;
              enableScreensaver = false;
            };
            displayManager.lightdm.enable = true;
          };
          displayManager.autoLogin = {
            enable = lib.mkForce true;
            user = lib.mkForce "andrec";
          };
        };

        nix.settings.trusted-users = [
          "root"
          "@wheel"
        ];
      };
      packages = {
        rescue-iso = inputs.self.nixosConfigurations.rescue.config.system.build.isoImage;
      };
    };
    schema.flake-system.includes = [ den.aspects.rescue ];
  };
}

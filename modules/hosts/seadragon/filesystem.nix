{ inputs, ... }:
{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko/latest";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.fs.seadragon = {
    nixos =
    {
      imports = [ inputs.disko.nixosModules.disko ];

      disko = {
        enableConfig = true;
        devices.disk.main = {
          type = "disk";
          device = "/dev/disk/by-id/ata-Samsung_SSD_850_EVO_500GB_S2RANX0H714792F";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/root" = { mountpoint = "/";   mountOptions = [ "compress=zstd" "noatime" ]; };
                    "/nix"  = { mountpoint = "/nix"; mountOptions = [ "compress=zstd" "noatime" ]; };
                    "/home" = { mountpoint = "/home"; mountOptions = [ "compress=zstd" "noatime" ]; };
                    "/swap" = { mountpoint = "/.swapvol"; swap.swapfile.size = "8G"; };
                  };
                };
              };
            };
          };
        };
      };

      # games disk — separate physical drive, managed outside disko
      fileSystems."/home/games" = {
        device = "/dev/disk/by-uuid/df5243df-6aa6-4a77-ae92-b71e9454548d";
        fsType = "btrfs";
      };
    };
  };
}

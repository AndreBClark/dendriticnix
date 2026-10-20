{ inputs }:
{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko/latest";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  den.aspects.fs.horizon = {
    nixos = {
      imports = [ inputs.disko.nixosModules.disko ];
      networking.hostId = "8876697a";

      disko.devices = {
        disk = {
          main = {
            type = "disk";
            device = "/dev/disk/by-id/ata-ST2000DX001-1NS164_Z4Z5MB0W"; # use by-id, not /dev/sdX
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  size = "1G";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                zfs = {
                  size = "100%";
                  content = {
                    type = "zfs";
                    pool = "zroot";
                  };
                };
              };
            };
          };
        };
        zpool = {
          zroot = {
            type = "zpool";
            options = {
              ashift = "12"; # 4K sectors
              autotrim = "off"; # HDD — trim irrelevant
            };
            rootFsOptions = {
              mountpoint = "none";
              compression = "zstd";
              acltype = "posixacl";
              xattr = "sa";
              copies = "2"; # <-- key: duplicate every block, self-heal bad sectors
              "com.sun:auto-snapshot" = "false";
            };
            datasets = {
              root = {
                type = "zfs_fs";
                mountpoint = "/";
              };
              "root/nix" = {
                type = "zfs_fs";
                mountpoint = "/nix";
              };
              "root/home" = {
                type = "zfs_fs";
                mountpoint = "/home";
              };
            };
          };
        };
      };
    };
  };
}

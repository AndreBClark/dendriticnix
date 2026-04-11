{
  den.aspects.fs = {
    nixos = {
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-uuid/e1a6a1a5-4413-4932-a959-bd40da6242f8";
          fsType = "ext4";
        };

        "/nix" = {
          device = "/dev/disk/by-uuid/c2acd9a7-3277-4306-a80e-8464233eaf72";
          fsType = "xfs";
        };

        "/home" = {
          device = "/dev/disk/by-uuid/50da5cfa-4e43-4d5a-b9bf-44678aadf9e2";
          fsType = "ext4";
        };

        "/boot" = {
          device = "/dev/disk/by-uuid/C155-F11E";
          fsType = "vfat";
          options = [
            "fmask=0022"
            "dmask=0022"
          ];
        };
      };
    };
  };
}

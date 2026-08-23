{
  den.aspects.fs = {
    dragonfly = {
      nixos = {
        fileSystems = {
          "/" = {
            device = "/dev/disk/by-uuid/a14f75ac-2317-4855-bbf0-0a7573230ff4";
            fsType = "ext4";
          };

          "/nix" = {
            device = "/dev/disk/by-uuid/ee815d90-f2fc-4b6c-9f61-57399fa28a07";
            fsType = "xfs";
          };

          "/home" = {
            device = "/dev/disk/by-uuid/a54cc6d7-a20d-4772-81d0-5da3517d6e07";
            fsType = "ext4";
          };

          "/boot" = {
            device = "/dev/disk/by-uuid/AEEE-0C0C";
            fsType = "vfat";
            options = [
              "fmask=0077"
              "dmask=0077"
            ];
          };
        };
        swapDevices = [ { device = "/dev/disk/by-uuid/3e14e991-8c6a-4e28-a852-f0504232fdc2"; } ];
      };
    };
  };
}

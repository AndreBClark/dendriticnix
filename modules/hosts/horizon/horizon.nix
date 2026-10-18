{ den, ... }:
{

  den = {
    hosts.x86_64-linux.horizon = {
      kernel = "cachyos";
      hardware = {
        cpu = "intel";
        gpu = "nvidia-nonprime-pascal";
        storage = [ "hdd" ];
      };
      users.andrec = { };
    };

    aspects.horizon = {
      includes = builtins.attrValues {
        inherit (den.aspects)
          base-host
          gaming
          ;
      };
    };
  };
}

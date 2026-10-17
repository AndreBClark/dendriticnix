{ den, ... }:
{
  den = {
    hosts.x86_64-linux.horizon = {
      hardware = {
        cpu = "intel";
        gpu = "nvidia-nonprime-pascal";
        storage = [ "hdd" ];
      };
      users.andrec = { };
    };

    aspects.seadragon = {
      includes = [
        den.aspects.base-host
        den.aspects.gaming
      ];
    };
  };
}

{ den, ... }:
{
  den.hosts.x86_64-linux.seadragon = {
    hardware = {
      cpu = "intel";
      gpu = "nvidia-nonprime-pascal";
      storage = [ "ssd" ];
    };
    users.andrec = { };
  };

  den.aspects.seadragon = {
    includes = [
      den.aspects.base-host
      den.aspects.apps.steam
    ];
  };
}

{ den, ... }:
{
  den = {
    aspects.dragonfly = {
      includes = [
        den.aspects.base-host
        den.aspects.hardware.laptop.dell-xps-15-9560
        den.aspects.apps.audacity
      ];
    };
    hosts.x86_64-linux.dragonfly = {
      hardware = {
        storage = [ "ssd" ];
        gpuMode = "hybrid";
      };
      users.andrec = { };
    };
  };
}

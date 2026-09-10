{ den, ... }:
{
  den = {
    aspects.dragonfly = {
      includes = [
        den.aspects.base-host
        den.aspects.hardware.laptop.dell-xps-15-9560
        den.aspects.audio-production
      ];
    };
    hosts.x86_64-linux.dragonfly = {
      hardware = {
        storage = [ "ssd" ];
        gpuMode = "intel";
      };
      users.andrec = { };
    };
  };
}

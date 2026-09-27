{ den, ... }:
{
  den = {
    aspects.dragonfly.includes = [
      den.aspects.base-host
      den.aspects.audio-production
    ];
    hosts.x86_64-linux.dragonfly = {
      hardware = {
        storage = [ "ssd" ];
        formFactor = "laptop";
        gpuMode = "intel";
        model = "dell-xps-15-9560";
      };
      users.andrec = { };
    };
  };
}

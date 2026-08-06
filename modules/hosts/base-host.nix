{ den, ... }:
{
  den.aspects.base-host =
    { host, ... }:
    {
      includes = [
        den.provides.hostname
        den.aspects.fs.${host.name}
        den.aspects.hardware.cpu
        den.aspects.hardware.storage
        den.aspects.vm
      ];
      nixos = { };
    };
}

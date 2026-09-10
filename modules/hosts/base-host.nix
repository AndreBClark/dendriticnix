{ den, ... }:
{
  den.aspects.base-host = { host, ... }: {
    includes = [
      den.batteries.hostname
      (den.aspects.fs.${host.name} or { })
      den.aspects.hardware
      den.aspects.development
    ];

    nixos = { };
  };
}

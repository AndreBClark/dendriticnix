{ den, ... }:
{
  den.aspects.base-host = { host, ... }: {
    includes = [
      den.batteries.hostname
      den.aspects.fs.${host.name}
      den.aspects.hardware
    ];

    nixos = { };
  };
}

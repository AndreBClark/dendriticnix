{ den, ... }:
{
  den.aspects.base-host = { host, ... }: {
    includes = [
      den.batteries.hostname
      den.aspects.hardware
      (den.aspects.fs.${host.hostName} or { })
      den.aspects.development
    ];

    nixos = { };
  };
}

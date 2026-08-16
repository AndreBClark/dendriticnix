{ den, ... }:
{
  den.aspects.hardware.cpu =
    { host, ... }:
    {
      includes = [ den.aspects.hardware.cpu.${host.hardware.cpu} ];
    };
}

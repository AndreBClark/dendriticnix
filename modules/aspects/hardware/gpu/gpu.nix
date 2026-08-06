{ den, ... }:
{
  den.aspects.hardware.gpu = { host, ... }:
    { includes = [ den.aspects.hardware.gpu.${host.hardware.gpu} ]; };
}

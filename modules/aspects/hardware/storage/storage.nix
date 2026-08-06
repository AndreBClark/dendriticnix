{ den, lib, ... }:
{
  den.aspects.hardware.storage = { host, ... }:
    {
      includes = map (t: den.aspects.hardware.storage.${t}) (host.hardware.storage or [ "ssd" ]);
    };
}

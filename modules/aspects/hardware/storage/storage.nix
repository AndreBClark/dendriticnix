{ den, ... }:
{
  den.aspects.hardware.storage =
    { host, ... }:
    {
      includes = map (t: den.aspects.hardware.storage.${t}) (host.hardware.storage or [ "ssd" ]);
      nixos = {
        services = {
          gvfs.enable = true;
          udisks2.enable = true;
          udiskie.enable = true;
        };
      };
    };
}

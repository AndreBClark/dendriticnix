{ den, ... }:
{
  den.aspects.kernel =
    { host, ... }:
    {
      includes = [
        den.aspects.kernel.${host.kernel or "latest"}
      ];
      latest = {
        nixos =
          { pkgs, ... }:
          {
            boot.kernelPackages = pkgs.linuxPackages_latest;
          };
      };
    };
}

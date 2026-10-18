{
  den.aspects.kernel.xanmod = {
    nixos =
      { pkgs, ... }:
      {
        boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;
      };
  };
}

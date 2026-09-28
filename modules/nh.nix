# Exposes flake apps under the name of each host / home for building with nh.
{ den, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages = lib.filterAttrs (n: _: !(lib.hasPrefix "vm-" n)) (
        den.lib.nh.denPackages { fromFlake = true; } pkgs
      );
    };
}

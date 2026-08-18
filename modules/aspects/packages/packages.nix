{
  den.aspects.my-packages.packages =
    { pkgs, ... }:
    {
      tinted-gowall = pkgs.callPackage ../../../pkgs/tinted-gowall {
        inherit (pkgs) gowall yq;
      };
    };
}

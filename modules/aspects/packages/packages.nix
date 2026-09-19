{
  den.aspects.my =
    let
      myPackages = pkgs: {
        tinted-gowall = pkgs.callPackage ../../../pkgs/tinted-gowall/package.nix {
          inherit (pkgs) gowall yq;
        };
      };
    in
    {
      packages = { pkgs, ... }: myPackages pkgs;
      homeManager =
        { pkgs, ... }:
        {
          home.packages = builtins.attrValues (myPackages pkgs);
        };
    };
}

{
  den.aspects.my-packages =
    let
      myPackages = pkgs: {
        tinted-gowall = pkgs.callPackage ../../../pkgs/tinted-gowall/package.nix {
          inherit (pkgs) gowall yq;
        };
        # nvim = inputs.nixvim.legacyPackages.${pkgs.stdenv.hostPlatform.system}.makeNixvimWithModule {
        #   inherit pkgs;
        #   module = { };
        # };
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

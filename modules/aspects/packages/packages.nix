{ inputs, ... }:
{
  den.aspects.my-packages.packages =
    { pkgs, ... }:
    {
      tinted-gowall = pkgs.callPackage ../../../pkgs/tinted-gowall {
        inherit (pkgs) gowall yq;
      };
      nvim = inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
        inherit pkgs;
        module = {
          # the shared programs.nixvim config
        };
      };
    };
}

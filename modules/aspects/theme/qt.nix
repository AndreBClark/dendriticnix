{
  den.aspects.theme.qt = {
    homeManager =
      { pkgs, ... }:
      let
        qtPlatform = "qtct";
      in
      {
        home.packages =
          builtins.attrValues {
            inherit (pkgs.kdePackages)
              qt6ct
              qtwayland
              qttools;
          };

        qt = {
          enable = true;
        };
        stylix.targets.qt = {
          enable = false;
          platform = qtPlatform;
        };
      };
  };
}

{ lib, ... }:
{
  den.aspects.theme.qt = {
    homeManager =
      { pkgs, ... }:
      let
        qtPlatform = "gtk3";
      in
      {
        home.packages = builtins.attrValues {
          inherit (pkgs.kdePackages) qt6ct;
        };

        qt = {
          enable = true;
          platformTheme = {
            name = lib.mkForce qtPlatform;
            package = pkgs.adw-gtk3;
          };
        };
      };
  };
}

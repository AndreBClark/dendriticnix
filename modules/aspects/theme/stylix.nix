{
  lib,
  inputs,
  den,
  ...
}:
{
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  den.aspects.stylix =
    { user, ... }:
    let
      inherit (user.theme)
        colorscheme
        opacity
        cursor
        iconTheme
        polarity
        ;
      theme = pkgs: {
        enable = true;
        inherit opacity polarity cursor;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorscheme}.yaml";
        icons = {
          enable = true;
          dark = lib.mkForce iconTheme;
          light = iconTheme;
          package = pkgs.dracula-icon-theme;
        };
      };

    in

    {
      includes = [
        den.aspects.fonts
        den.aspects.theme.gtk
        den.aspects.theme.qt
      ];
      nixos =
        { pkgs, ... }:
        {
          imports = [
            inputs.stylix.nixosModules.stylix
          ];
          stylix = theme pkgs;
          environment.systemPackages = builtins.attrValues {
            inherit (pkgs)
              rose-pine-cursor
              adwaita-icon-theme
              hicolor-icon-theme
              ;
          };
          xdg.icons.enable = true;
        };

      homeManager =
        {
          pkgs,
          osConfig ? null,
          ...
        }:
        {
          imports = lib.optionals (osConfig == null) [
            inputs.stylix.homeModules.stylix
          ];
          stylix = lib.mkIf (osConfig == null) (theme pkgs);
          home.packages = [
            pkgs.rose-pine-cursor
          ];
        };

    };
}

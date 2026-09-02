{ inputs, den, ... }:
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
        inherit opacity polarity;
        cursor = {
          inherit (cursor) name size;
          package = pkgs.${cursor.package};
        };

        base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorscheme}.yaml";
        icons = {
          enable = true;
          dark = iconTheme;
          light = iconTheme;
          package = pkgs.dracula-icon-theme;
        };
      };
    in
    {
      includes = builtins.attrValues {
        inherit (den.aspects.theme) fonts gtk qt;
      };

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
        { pkgs, ... }:
        {
          stylix = theme pkgs;

          home.packages = [
            pkgs.${cursor.package}
          ];
        };

    };
  den.schema.home.instantiate =
    { pkgs, modules }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = modules ++ [ inputs.stylix.homeModules.stylix ];
    };
}

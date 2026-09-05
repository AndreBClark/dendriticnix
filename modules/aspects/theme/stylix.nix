{
  inputs,
  den,
  lib,
  ...
}:
{
  flake-file.inputs = {
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den = {
    aspects.stylix =
      { user, ... }:
      let
        theme = den.profiles.${user.name}.theme or user.theme;
        inherit (theme)
          opacity
          cursor
          icons
          polarity
          ;
        stylix =
          pkgs:
          let
            base16Scheme = ./tokyo-night-neon.yaml;
            # base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorscheme}.yaml";
          in
          {
            enable = true;
            inherit opacity polarity base16Scheme;

            cursor = {
              inherit (cursor) name size;
              package = pkgs.${cursor.package};
            };
            icons = {
              enable = true;
              inherit (icons) dark light;
              package = pkgs.${icons.package};
            };

            targets = {
              gtksourceview.enable = lib.mkDefault false;
              gnome.enable = lib.mkDefault false;
              gnome-text-editor.enable = lib.mkDefault false;
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

            stylix = stylix pkgs;

            environment.systemPackages = [
              pkgs.${cursor.package}
            ]
            ++ builtins.attrValues {
              inherit (pkgs)
                adwaita-icon-theme
                hicolor-icon-theme
                ;
            };
            xdg.icons.enable = true;
          };

        homeManager =
          { pkgs, ... }:
          {
            stylix = stylix pkgs // {
              targets = {
                blender.enable = lib.mkDefault false;
              };
            };

            home.packages = [
              pkgs.${cursor.package}
            ];
          };

      };
    schema.home.instantiate =
      { pkgs, modules }:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = modules ++ [ inputs.stylix.homeModules.stylix ];
      };
  };
}

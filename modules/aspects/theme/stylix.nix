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
    lib.theme.stylixConfig =
      { user, ... }:
      let
        theme = den.lib.theme.resolveTheme { inherit user; };
        inherit (theme)
          opacity
          cursor
          icons
          polarity
          ;
        base16Scheme =
          let
            attempt = builtins.tryEval theme.colorscheme;
          in
          if attempt.success then attempt.value else "tokyo-night-moon";
      in
      {
        enable = true;
        inherit
          opacity
          polarity
          base16Scheme
          cursor
          icons
          ;

        targets = {
          gnome.enable = lib.mkForce false;
          gtksourceview.enable = lib.mkForce false;
          gnome-text-editor.enable = lib.mkForce false;
        };
      };

    aspects.theme =
      { user, ... }:
      let
        stylix = den.lib.theme.stylixConfig { inherit user; };
        stylixPackages = pkgs: {
          cursor = {
            inherit (stylix.cursor) name size;
            package = pkgs.${stylix.cursor.package};
          };
          icons = {
            inherit (stylix.icons) enable dark light;
            package = pkgs.${stylix.icons.package};
          };
        };
      in
      {
        includes = builtins.attrValues {
          inherit (den.aspects.theme)
            fonts
            gtk
            qt
            icons
            ;
        };

        nixos =
          { pkgs, ... }:
          {
            imports = [ inputs.stylix.nixosModules.stylix ];
            stylix = stylix // {
              inherit (stylixPackages pkgs) cursor icons;
              homeManagerIntegration.autoImport = false;
            };
            environment.systemPackages = [
              pkgs.${stylix.cursor.package}
              pkgs.${stylix.icons.package}
              pkgs.dracula-icon-theme
            ]
            ++ builtins.attrValues {
              inherit (pkgs)
                adwaita-icon-theme
                hicolor-icon-theme
                papirus-icon-theme
                ;
            };
            xdg.icons.enable = true;
          };

        homeManager =
          { pkgs, ... }:
          {
            imports = [ inputs.stylix.homeModules.stylix ];
            stylix = stylix // {
              inherit (stylixPackages pkgs) cursor icons;
              targets = {
                blender.enable = lib.mkDefault false;
                rofi.enable = false;
              };
            };
            home.packages = [
              pkgs.${stylix.cursor.package}
              pkgs.${stylix.icons.package}
              pkgs.dracula-icon-theme
            ]
            ++ builtins.attrValues {
              inherit (pkgs)
                adwaita-icon-theme
                hicolor-icon-theme
                papirus-icon-theme
                ;
            };
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

{ lib, inputs, ... }:
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
      inherit (user.theme) colorscheme variant opacity cursorName iconTheme polarity;
      theme = pkgs: {
        enable = true;
        inherit opacity polarity;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/${colorscheme}-${variant}.yaml";
        icons = {
          enable = true;
          dark = lib.mkForce iconTheme;
          light = iconTheme;
          package = pkgs.dracula-icon-theme;
        };
        cursor = {
          name = cursorName;
          package = pkgs.rose-pine-cursor;
          size = 24;
        };
      };
    in
    {
      nixos =
        { den, pkgs, ... }:
        {
          includes = [ den.aspects.fonts ];
          imports = [
            inputs.stylix.nixosModules.stylix
          ];
          stylix = theme pkgs;
          environment.systemPackages = [
            pkgs.rose-pine-cursor
          ];
        };

      homeManager =
        { den, pkgs, osConfig ? null, ... }:
        {
          includes = [ den.aspects.fonts ];
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

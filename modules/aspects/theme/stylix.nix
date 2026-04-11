{
  den,
  pkgs,
  lib,
  config,
  ...
}:
let
  theme = {
    enable = true;
    colorscheme = "tokyo-night";
    variant = "moon";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme.colorscheme}-${theme.variant}.yaml";
    opacity = {
      desktop = 1.0;
      popups = 1.0;
      applications = 1.0;
    };
    icons = {
      enable = true;
      dark = lib.mkForce "Dracula";
      light = config.stylix.icons.dark;
      package = pkgs.dracula-icon-theme;
    };
    cursor = {
      name = "Volantes Cursors";
      package = pkgs.volantes-cursors;
      size = 24;
    };
    image = theme.wallpaper;
    polarity = "dark";
  };
in
{
  den.aspects.stylix = {
    os.stylix = theme;
    homeManager.stylix = theme;
    nixos.environment.systemPackages = [ pkgs.volantes-cursors ];
    homeManager.home.packages = [ pkgs.volantes-cursors ];
  };
}

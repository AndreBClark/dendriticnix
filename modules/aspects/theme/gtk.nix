{
  den.aspects.theme.gtk = {
    nixos = {
      programs.dconf.enable = true;
      gtk.iconCache.enable = true;
    };
    homeManager =
      { config, ... }:
      {
        gtk = {
          enable = true;
          gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
          gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
          gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
        };
      };
  };
}

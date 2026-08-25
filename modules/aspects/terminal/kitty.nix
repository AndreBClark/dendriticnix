{
  den.aspects.terminal.kitty = {
    homeManager =
      { config, ... }:
      let
        colors = config.lib.stylix.colors.withHashtag;
        pillRight = "";
        pillLeft = "";
        tabBarPy =
          builtins.replaceStrings
            [
              "@BODY_BG@"
              "@BODY_FG@"

              "@TAB01@"
              "@TAB02@"
              "@TAB03@"
              "@TAB04@"
              "@TAB05@"
              "@TAB06@"
              "@TAB07@"
              "@TAB08@"

              "@INDEX_FG@"
              "@PILL_LEFT@"
              "@PILL_RIGHT@"
            ]
            [
              colors.base01
              colors.base05

              colors.base0E
              colors.base0C
              colors.base0D
              colors.base0A
              colors.base14
              colors.base15
              colors.base16
              colors.base17

              colors.base01

              pillLeft
              pillRight
            ]
            (builtins.readFile ./tab_bar.py);
      in
      {
        programs.kitty = {
          enable = true;
          settings = {
            tab_title_template = "{tab.active_wd}{activity_symbol}";
            tab_title_max_length = 0;
            tab_bar_edge = "top";
            tab_bar_style = "custom";
            tab_bar_margin_height = "0 0";
            tab_fade = "0 0";
            tab_bar_margin_color = "none";
          };
          extraConfig = ''
            tab_background ${colors.base01}
            active_tab_background   ${colors.base03}
            active_tab_foreground   ${colors.base05}
            inactive_tab_background ${colors.base02}
            inactive_tab_foreground ${colors.base04}
          '';
        };

        xdg.configFile."kitty/tab_bar.py".text = tabBarPy;
      };
  };
}

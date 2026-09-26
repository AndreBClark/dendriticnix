{
  den.aspects.terminal.kitty = {
    homeManager =
      { config, ... }:
      let
        colors = config.lib.stylix.colors.withHashtag;
        separator = {
          left = "";
          right = "";
        };

        tabBarPy =
          with colors;
          file:
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
              base02
              base05

              base0E
              base0D
              base0C
              base0B
              base0A
              base08
              base13
              base14

              base01

              separator.left
              separator.right
            ]
            (builtins.readFile file);
      in
      {
        programs.kitty = {
          enable = true;
          settings =
            let
              monoName = config.stylix.fonts.monospace.name;
            in
            {
              font_family = "family='${monoName}' style=SemiBold";
              bold_font = "family='${monoName}' style=ExtraBold";
              bold_italic_font = "family='${monoName}' style='ExtraBold Italic'";
              tab_bar_edge = "top";
              tab_bar_style = "custom";
              window_padding_width = 6;
              cursor_shape = "block";
              cursor_trail = 50;
              tab_bar_margin_width = 6;
              tab_title_max_length = 0;
              tab_bar_min_tabs = 0;
              shell_integration = "no-rc no-cursor";
              enable_audio_bell = false;
              enabled_layouts = "tall,stack";
            };
          keybindings = {
            "ctrl+shift+T" = "new_tab_with_cwd";
          };
          extraConfig = ''
            active_tab_background  ${colors.base02}
            active_tab_foreground  ${colors.base0C}
            inactive_tab_background ${colors.base00}
            inactive_tab_foreground  ${colors.base03}
            custom_shaders cursor-trail-blaze
          '';
        };

        xdg.configFile."kitty/tab_bar.py".text = tabBarPy ./tab_bar.py;
      };
  };
}

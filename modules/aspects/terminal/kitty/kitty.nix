{
  den.aspects.terminal.kitty = {
    homeManager =
      { config, ... }:
      let
        colors = config.lib.stylix.colors.withHashtag;
        pillRight = "";
        pillLeft = "";
        tabBarPy =
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
              colors.base02
              colors.base05

              colors.base0E
              colors.base0D
              colors.base0C
              colors.base0B
              colors.base0A
              colors.base08
              colors.base13
              colors.base14

              colors.base01

              pillLeft
              pillRight
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
              active_tab_font_style = "bold";
              window_padding_width = 4;
            };
          keybindings = {
            "ctrl+shift+T" = "new_tab_with_cwd";
          };
          extraConfig =
            let
              emojiFont = config.stylix.fonts.emoji.name;
            in
            ''
              active_tab_background  ${colors.base03}
              active_tab_foreground  ${colors.base08}
              inactive_tab_background ${colors.base00}
              inactive_tab_foreground  ${colors.base03}
              symbol_map U+e000-U+e00a,U+ea60-U+ebeb,U+e0a0-U+e0c8,U+e0ca,U+e0cc-U+e0d4,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b1,U+e700-U+e7c5,U+f000-U+f2e0,U+f300-U+f372,U+f400-U+f532,U+f0001-U+f1af0 Symbols Nerd Font Mono
              symbol_map U+1F300-U+1FAFF,U+2600-U+27BF,U+1F1E6-U+1F1FF,U+2300-U+23FF ${emojiFont}
            '';
        };

        xdg.configFile."kitty/tab_bar.py".text = tabBarPy ./tab_bar.py;
      };
  };
}

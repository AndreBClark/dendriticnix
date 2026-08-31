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
            };
          keybindings = {
            "ctrl+shift+T" = "new_tab_with_cwd";
          };
          extraConfig =
            # let
            #   emojiFont = config.stylix.fonts.emoji.name;
            # in
            ''
              active_tab_background  ${colors.base03}
              active_tab_foreground  ${colors.base08}
              inactive_tab_background ${colors.base00}
              inactive_tab_foreground  ${colors.base03}
            '';
          #   # ======= Nerd Font Symbols =======
          #   symbol_map U+E000-U+E00D,U+E0A0-U+E0D4,U+E200-U+E2A9,U+E300-U+E3EB,U+E5FA-U+E62B,U+E700-U+E7C5,U+F000-U+F4A8,U+F500-U+FD46 Symbols Nerd Font
          #   # Misc Code Point Fixes
          #   symbol_map U+21B5,U+25B8,U+2605,U+2630,U+2632 Symbols Nerd Font
          #   # Font Power Symbols
          #   symbol_map U+23E9-U+23F4,U+23F6-U+23FE,U+2B58-U+2B58 Symbols Nerd Font
          #   symbol_map U+2714,U+23F5 family="Noto Sans Symbols 2"
          #   # ======= Emojis =======
          #   symbol_map U+1F000-U+1FAFF,U+2600-U+26FF,U+2700-U+27BF,U+2B00-U+2BFF,U+FE0E-U+FE0F,U+2300-U+23FF ${emojiFont}
          # '';
        };

        xdg.configFile."kitty/tab_bar.py".text = tabBarPy ./tab_bar.py;
      };
  };
}

{
  den.aspects.terminal.kitty = {
    homeManager =
      { pkgs, config, ... }:
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

              #REF https://github.com/ns8wastaken/nixos-config/blob/88644b03a14ab66bc3d125a3052c4bc3417620cd/users/ns8/dotfiles/.config/kitty/kitty.conf.nixified.nix#L34
              # ======= Nerd Font Symbols =======
              # Pomicons
              symbol_map U+E000-U+E00D Symbols Nerd Font
              # Powerline
              symbol_map U+E0A0-U+E0A2,U+E0B0-U+E0B3 Symbols Nerd Font
              # Powerline Extra
              symbol_map U+E0A3-U+E0A3,U+E0B4-U+E0C8,U+E0CC-U+E0D2,U+E0D4-U+E0D4 Symbols Nerd Font
              # Symbols original
              symbol_map U+E5FA-U+E62B Symbols Nerd Font
              # Devicons
              symbol_map U+E700-U+E7C5 Symbols Nerd Font
              # Font awesome
              symbol_map U+F000-U+F2E0 Symbols Nerd Font
              # Font awesome extension
              symbol_map U+E200-U+E2A9 Symbols Nerd Font
              # Octicons
              symbol_map U+F400-U+F4A8,U+2665-U+2665,U+26A1-U+26A1,U+F27C-U+F27C Symbols Nerd Font
              # Font Linux
              symbol_map U+F300-U+F313 Symbols Nerd Font
              # Font Power Symbols
              symbol_map U+23FB-U+23FE,U+2B58-U+2B58 Symbols Nerd Font
              # Material Design Icons
              symbol_map U+F500-U+FD46 Symbols Nerd Font
              # Weather Icons
              symbol_map U+E300-U+E3EB Symbols Nerd Font
              # Misc Code Point Fixes
              symbol_map U+21B5,U+25B8,U+2605,U+2630,U+2632,U+2714,U+E0A3,U+E615,U+E62B Symbols Nerd Font
              # ======= Noto Color Emojis =======
              # Emojis
              symbol_map U+1F000-U+1FAFF,U+2600-U+26FF,U+2700-U+27BF,U+2B00-U+2BFF,U+FE0E-U+FE0F,U+2300-U+23FF ${emojiFont}
            '';
        };

        home.packages = [
          pkgs.nerd-fonts.symbols-only
          pkgs.noto-fonts-color-emoji
        ];
        xdg.configFile."kitty/tab_bar.py".text = tabBarPy ./tab_bar.py;
      };
  };
}

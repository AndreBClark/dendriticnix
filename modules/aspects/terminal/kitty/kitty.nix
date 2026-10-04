{
  den.aspects.terminal.kitty = {
    homeManager =
      { config, ... }:
      let
        c = config.lib.stylix.colors;
        colors = c.withHashtag;
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
              window_padding_width = "0 6";
              cursor_shape = "block";
              cursor_trail = 1;
              tab_bar_margin_width = 6;
              tab_title_max_length = 0;
              tab_bar_min_tabs = 0;
              enable_audio_bell = false;
              enabled_layouts = "tall,stack";
              custom_shaders = "cursor-trail-blaze-blue";
            };

          keybindings = {
            "ctrl+shift+T" = "new_tab_with_cwd";
          };

          extraConfig = with colors; ''
            cursor                   ${base0C}
            cursor_trail_color       ${base0C}
            active_tab_background    ${base02}
            active_tab_foreground    ${base0C}
            inactive_tab_background  ${base01}
            inactive_tab_foreground  ${base03}
            tab_bar_background       ${base00}
          '';
        };

        xdg.configFile."kitty/tab_bar.py".text = tabBarPy ./tab_bar.py;

        xdg.configFile."kitty/shaders/cursor-trail-blaze-blue.pipeline".text =
          let
            base0D = "float3(${c.base0D-dec-r}, ${c.base0D-dec-g}, ${c.base0D-dec-b})";
            base0C = "float3(${c.base0C-dec-r}, ${c.base0C-dec-g}, ${c.base0C-dec-b})";
          in
          ''
            startgroup
              animation_start cursor-trail-move
              animation_stop cursor-trail-stop
              var float4 TRAIL_COLOR = float4(pow(${base0D},float3(2.2)), 1.0)
              var float4 TRAIL_COLOR_ACCENT = float4(pow(${base0C}, float3(2.2)), 1.0)
              var float DURATION = 0.45
              shaders cursor-trail-blaze
            endgroup
          '';
      };
  };
}

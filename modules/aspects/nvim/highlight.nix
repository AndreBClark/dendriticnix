{
  den.aspects.nvim.highlight = {
    nixvim = {
      highlightOverride = {
        Visual.link = "lualine_a_visual";
        lualine_a_mode_command = {
          link = "User4";
          reverse = true;
        };
      };

      plugins = {
        mini-hipatterns = {
          enable = true;
          settings.highlighters.hex_color.__raw = ''
            require('mini.hipatterns').gen_highlighter.hex_color()
          '';
        };
      };
    };
  };
}

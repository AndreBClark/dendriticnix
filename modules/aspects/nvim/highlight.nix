{
  den.aspects.nvim.highlight = {
    homeManager =
      { config, ... }:
      let
        colors = config.lib.stylix.colors.withHashtag;
      in
      {
        programs.nixvim = {
          highlight = with colors; {
            CursorLine = {
              bg = base02;
              blend = 50;
            };
            Visual = {
              fg = base01;
              bg = base0E;
              blend = 50;
            };

          };
          plugins = {
            mini-hipatterns = {
              enable = true;
              settings.highlighters.hex_color.__raw = "require('mini.hipatterns').gen_highlighter.hex_color()";
            };
          };
        };
      };
  };
}

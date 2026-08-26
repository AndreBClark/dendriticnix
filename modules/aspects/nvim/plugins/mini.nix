{
  den.aspects.nvim.mini = {
    homeManager = {
      programs.nixvim.plugins = {
        mini-basics.enable = true;
        mini.mockDevIcons = true;
        mini-diff.enable = true;
        mini-pairs.enable = true;
        mini-surround.enable = true;
        mini-hipatterns = {
          enable = true;
          settings.highlighters.hex_color.__raw = "require('mini.hipatterns').gen_highlighter.hex_color()";
        };
      };
    };
  };
}

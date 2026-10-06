{ lib, config, ... }:
{
  highlightOverride =
    let
      transparent = {
        bg = "none";
        ctermbg = "none";
      };
      transparentBackground = {
        main = true;
        signColumn = false;
        numberLine = false;
      };
      colors = config.colorschemes.base16.colorscheme;
    in
    {
      Normal = lib.mkIf transparentBackground.main transparent;
      NonText = lib.mkIf transparentBackground.main transparent;
      SignColumn = lib.mkIf transparentBackground.signColumn transparent;
      LineNr = lib.mkIf transparentBackground.numberLine transparent;
      LineNrAbove = lib.mkIf transparentBackground.numberLine transparent;
      LineNrBelow = lib.mkIf transparentBackground.numberLine transparent;
      Visual.link = "lualine_a_visual";
      GitSignsCurrentLineBlame.fg = colors.base01;
      Statusline = lib.mkIf transparentBackground.main transparent;
    };

  plugins.mini-hipatterns = {
    enable = true;
    settings.highlighters = {
      hex_color.__raw = ''
        require('mini.hipatterns').gen_highlighter.hex_color()
      '';
      fixme = {
        pattern = "%f[%w]()FIXME.*$";
        group = "MiniHipatternsFixme";
      };
      hack = {
        pattern = "%f[%w]()HACK.*$";
        group = "MiniHipatternsHack";
      };
      todo = {
        pattern = "%f[%w]()TODO.*$";
        group = "MiniHipatternsTodo";
      };
      note = {
        pattern = "%f[%w]()NOTE.*$";
        group = "MiniHipatternsNote";
      };
    };
  };
}

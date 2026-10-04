{ lib, ... }:
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
    in
    {
      Normal = lib.mkIf transparentBackground.main transparent;
      NonText = lib.mkIf transparentBackground.main transparent;
      SignColumn = lib.mkIf transparentBackground.signColumn transparent;
      LineNr = lib.mkIf transparentBackground.numberLine transparent;
      LineNrAbove = lib.mkIf transparentBackground.numberLine transparent;
      LineNrBelow = lib.mkIf transparentBackground.numberLine transparent;
      Visual.link = "lualine_a_visual";
    };

  plugins = {
    mini-hipatterns = {
      enable = true;
      settings.highlighters.hex_color.__raw = ''
        require('mini.hipatterns').gen_highlighter.hex_color()
      '';
    };
  };
}

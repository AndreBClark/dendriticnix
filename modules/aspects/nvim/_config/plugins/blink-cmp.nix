{
  plugins = {
    blink-cmp = {
      enable = true;
      setupLspCapabilities = true;
      settings = {
        keymap.preset = "super-tab";
        signature.enabled = true;
        snippets.preset = "mini_snippets";
        completion = {
          menu = {
            border = "rounded";
            auto_show = true;
          };

          documentation = {
            auto_show = true;
          };
        };
        cmdline = {
          keymap.preset = "inherit";
          completion.menu.auto_show = true;
        };
        sources = {
          default = [
            "buffer"
            "lsp"
            "path"
            "snippets"
            "dictionary"
            "ripgrep"
          ];
          providers = {
            ripgrep = {
              name = "Ripgrep";
              module = "blink-ripgrep";
              score_offset = 1;
            };
            dictionary = {
              name = "Dict";
              module = "blink-cmp-dictionary";
              min_keyword_length = 3;
            };
          };
        };
      };
    };
    blink-cmp-dictionary.enable = true;
    blink-ripgrep.enable = true;
    luasnip.enable = true;
    mini-snippets.enable = true;
  };
}

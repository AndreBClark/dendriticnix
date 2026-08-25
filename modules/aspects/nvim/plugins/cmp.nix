{
  den.aspects.nvim = {
    provides.cmp = {
      homeManager = {
        programs.nixvim = {
          plugins = {
            cmp = {
              enable = true;
              settings = {
                sources = [
                  { name = "nvim_lsp"; }
                  { name = "nvim_lsp_signature_help"; }
                  { name = "path"; }
                  { name = "buffer"; }
                  { name = "luasnip"; }
                  { name = "treesitter"; }
                  { name = "yanky"; }
                  { name = "fish"; }
                ];

                # Win #1: snippet.expand — required for luasnip source to expand snippets
                snippet.expand = ''
                  function(args)
                    require('luasnip').lsp_expand(args.body)
                  end
                '';

                mapping = {
                  "<Tab>" = "cmp.mapping.select_next_item()";
                  "<S-Tab>" = "cmp.mapping.select_prev_item()";
                  "<C-j>" = "cmp.mapping.scroll_docs(4)";
                  "<C-k>" = "cmp.mapping.scroll_docs(-4)";
                  "<C-Space>" = "cmp.mapping.complete()";
                  "<C-Esc>" = "cmp.mapping.close()";
                  "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
                  "<Up>" = "cmp.mapping.select_prev_item()";
                  "<Down>" = "cmp.mapping.select_next_item()";
                  "<Left>" = "cmp.mapping.close()";
                  "<Right>" = "cmp.mapping.confirm({ select = true })";
                };

                # Win #5: ghost text preview + auto-open docs
                experimental.ghost_text = true;
                view.docs.auto_open = true;
              };

              # Win #3: cmdline completion for `:` and `/`
              cmdline = {
                "/" = {
                  mapping.__raw = "cmp.mapping.preset.cmdline()";
                  sources = [ { name = "buffer"; } ];
                };
                ":" = {
                  mapping.__raw = "cmp.mapping.preset.cmdline()";
                  sources = [
                    { name = "path"; }
                    { name = "cmdline"; }
                  ];
                };
              };
            };
          };
        };
      };
    };
  };
}

{
  den.aspects.nvim.treesitter = {
    nixvim =
      { pkgs, ... }:
      {
        plugins = {
          treesitter = {
            enable = true;
            nixGrammars = true;
            grammarPackages = builtins.attrValues {
              inherit (pkgs.vimPlugins.nvim-treesitter.builtGrammars)
                nix
                javascript
                typescript
                lua
                astro
                json
                yaml
                kdl
                html
                css
                ;
            };
            folding.enable = true;
            highlight.enable = true;
            indent.enable = true;
            settings.incremental_selection = {
              enable = true;
              keymaps = {
                init_selection = "v<CR>";
                node_incremental = "<CR>";
                node_decremental = "<BS>";
                scope_incremental = "<C-CR>";
              };
            };
          };

          treesitter-context = {
            enable = true;
            settings = {
              max_lines = 6;
            };
          };
          ts-context-commentstring.enable = true;

          comment = {
            enable = true;
            settings = {
              pre_hook = /* lua */ ''
                require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
              '';
            };
          };
        };
      };
  };
}

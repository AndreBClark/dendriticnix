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
          bash
          jsdoc
          regex
          tsx
          svelte
          jq
          ;
      };
      folding.enable = true;
      highlight.enable = true;
      indent.enable = true;
    };

    treesitter-context = {
      enable = true;
      settings = {
        max_lines = 3; # reduce from 6 — less overlay area
        min_window_height = 30; # hide context entirely in short windows
        mode = "cursor"; # anchor context to cursor scope, not window top
        trim_scope = "inner";
        multiline_threshold = 3;
      };
    };

    wildfire = {
      enable = true;
      settings = {
        filetype_exclude = [
          "qf"
        ];
        keymaps = {
          init_selection = "<CR>";
          node_decremental = "<BS>";
          node_incremental = "<CR>";
        };
        surrounds = [
          [
            "("
            ")"
          ]
          [
            "{"
            "}"
          ]
          [
            "<"
            ">"
          ]
          [
            "["
            "]"
          ]
          [
            "{"
            "};"
          ]
          [
            "["
            "];"
          ]
          [
            "("
            ");"
          ]
        ];
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
}

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
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    # These depend on treesitter and should work with the above config
    ts-context-commentstring.enable = true;
    comment = {
      enable = true;
      settings = {
        pre_hook = "require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()";
      };
    };
    # treesitter-context.enable = true;
  };
}

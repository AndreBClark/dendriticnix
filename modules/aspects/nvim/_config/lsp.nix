{
  lib,
  config,
  ...
}:
{
  lsp = {
    inlayHints.enable = true;
    codelens.enable = true;
    servers = {
      nixd = {
        enable = true;
        config = {
          formatting.command = [ "nixfmt" ];
          nixpkgs.expr = "import (builtins.getFlake \"pkgs\") { }";
        };
      };
      ts_ls.enable = true;
      biome = {
        enable = true;
        config = {
          linter = {
            enabled = true;
            rules.recommended = true;
          };
          assist = {
            enabled = true;
            actions.source.organizeImports = "on";
          };
        };
      };
      cssls.enable = true;
      tailwindcss.enable = true;
      html.enable = true;
      astro.enable = true;
      svelte.enable = true;

      jsonls.enable = true;
      pyright.enable = true;
      marksman = {
        enable = true;
        config.markdown.preferredLinkStyle = "wiki";
      };
      bashls.enable = true;
      yamlls.enable = true;
    };
  };
  plugins = {
    lspconfig.enable = true;
    lsp-format.enable = true;
    lspkind.enable = true;

    lint.enable = true;
    trim.enable = true;
    fastaction = {
      enable = true;
    };

    none-ls = {
      enable = true;
      sources = {
        formatting = {
          nixfmt.enable = true;
          stylua.enable = true;
          biome.enable = true;
        };

        diagnostics = {
          statix.enable = true;
          deadnix.enable = true;
        };

        code_actions = {
          statix.enable = true;
        };
      };
    };
  };
  keymaps = lib.optional (config.plugins.fastaction.enable or false) {
    mode = [
      "n"
      "v"
    ];
    key = "<leader>ca";
    action.__raw = ''
      function() require('fastaction').code_action({
        filter = function(action) return not action.disabled end,
      }) end
    '';
    options.desc = "Code action";
  };
}

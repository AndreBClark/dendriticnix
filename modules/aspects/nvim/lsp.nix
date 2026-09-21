{ den, lib, ... }:
{
  den.aspects.nvim.lsp = {
    includes = builtins.attrValues {
      inherit (den.aspects.nvim.lsp) web nix;
    };
    nixvim =
      { pkgs, config, ... }:
      {
        lsp = {
          inlayHints.enable = true;
          codelens.enable = true;
          servers = {
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
          fastaction.enable = true;

          none-ls.enable = true;
          lint.lintersByFt = {
            json = [ "jq" ];
          };
        };
        keymaps = lib.optional (config.plugins.fastaction.enable or false) {
          mode = [
            "n"
            "v"
          ];
          key = "<leader>ca";
          action.__raw = "function() require('fastaction').code_action() end";
          options.desc = "Code action";
        };
        extraPackages = [
          pkgs.jq
        ];
      };
    nix.nixvim = {
      lsp.servers.nixd = {
        enable = true;
        config = {
          formatting.command = [ "nixfmt" ];
          nixpkgs.expr = "import (builtins.getFlake \"pkgs\") { }";
        };
      };
      plugins.none-ls = {
        enable = true;
        sources = {
          formatting = {
            nixfmt.enable = true;
            stylua.enable = true;
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

    web.nixvim = {
      lsp.servers = {
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
      };
      plugins = {
        none-ls = {
          enable = true;
          sources.formatting.biome.enable = true;
        };
      };
    };
  };
}

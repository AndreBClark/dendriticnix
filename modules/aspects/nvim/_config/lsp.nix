{
  lib,
  config,
  pkgs,
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
          options = {
            nixos.expr = ''
              (builtins.getFlake ("git+file://" + builtins.toString ./.))
                .nixosConfigurations.seadragon.options
            '';
            home-manager.expr = ''
              (builtins.getFlake ("git+file://" + builtins.toString ./.))
                .nixosConfigurations.seadragon.options.home-manager.users.type.getSubOptions []
            '';
            nixvim.expr = "(builtins.getFlake \"path/to/flake\").packages.${pkgs.stdenv.hostPlatform.system}.nixvim.options";
          };
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
    trouble.enable = true;
    lint.enable = true;
    trim.enable = true;
    fastaction = {
      enable = true;
    };

    tiny-inline-diagnostic = {
      enable = true;
      settings = {
        show_all_diags_on_cursorline = true;
        options = {

          multilines = {
            enabled = true;
            always_show = true;
            trim_whitespaces = true;
            tabstop = 4;
          };
          show_source.if_many = true;
          break_line = {
            enabled = true;
            after = 70;
          };
          virt_texts.priority = 2048;
        };
      };
    };

    refactoring = {
      enable = true;
      enableTelescope = false;
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
  keymaps =
    let
      cfg = config.plugins;
    in
    lib.optional (cfg.fastaction.enable or false) {
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
    }
    ++ (lib.optional (cfg.trouble.enable or false) {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<CR>";
      options.desc = "Toggle Diagnostics (Trouble)";
    })
    ++ (lib.optional (cfg.refactoring.enable or false) {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>cr";
      action.__raw = "function() require('refactoring').select_refactor() end";
      options.desc = "Select Refactor";
    });
}

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
      ts_ls = {
        enable = true;
        config.before_init.__raw = ''
          function(_, config)
            local root = config.root_dir
            local ws = root and (root .. "/node_modules/typescript/lib")
            if ws and vim.uv.fs_stat(ws .. "/tsserverlibrary.js") then
              config.init_options = config.init_options or {}
              config.init_options.typescript = config.init_options.typescript or {}
              config.init_options.typescript.tsdk = ws
            end
          end
        '';
        config.init_options.typescript.tsdk = "${pkgs.typescript}/lib/node_modules/typescript/lib";
      };
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

    # TODO: show diagnostics as count instead of dots
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
      lazyLoad.settings.keys = [
        {
          __unkeyed-1 = "<leader>cr";
          __unkeyed-2.__raw = "function() require('refactoring').select_refactor() end";
          mode = [
            "n"
            "x"
          ];
          desc = "Select Refactor";
        }
      ];
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
      options.desc = "Toggle (Trouble)";
    });
}

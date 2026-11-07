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
      statix.enable = true;

      oxlint = {
        enable = true;
        config = {
          init_options = {
            run = "onType";
            fixKind = "safe_fix_or_suggestion";
            unusedDisableDirectives = "warn";
            typeAware = true;
          };
          filetypes = [
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
            "vue"
            "svelte"
          ];
        };
      };

      # ── oxc: textDocument/formatting ──
      oxfmt.enable = true;
      ts_ls = {
        enable = true;
        config = {
          filetypes = [
            "javascript"
            "javascriptreact"
            "javascript.jsx"
            "typescript"
            "typescriptreact"
            "typescript.tsx"
            "vue"
          ];
          before_init.__raw = ''
            function(_, config)
              local root = config.root_dir
              if not root then return end

              local ws = root .. "/node_modules/typescript/lib"
              if vim.uv.fs_stat(ws .. "/tsserverlibrary.js") then
                config.init_options = config.init_options or {}
                config.init_options.typescript = config.init_options.typescript or {}
                config.init_options.typescript.tsdk = ws
              end

              local astro_plugin = root .. "/node_modules/@astrojs/ts-plugin"
              if vim.uv.fs_stat(astro_plugin .. "/dist/index.js") then
                config.init_options.plugins = config.init_options.plugins or {}
                table.insert(config.init_options.plugins, {
                  name = "@astrojs/ts-plugin",
                  location = astro_plugin,
                })
              end
            end
          '';
          init_options = {
            typescript.tsdk = "${pkgs.typescript_5}/lib/node_modules/typescript/lib";
            plugins = [
              {
                name = "@vue/typescript-plugin";
                location = "${pkgs.vue-language-server}/lib/language-tools/packages/language-server";
                languages = [ "vue" ];
              }
            ];
          };
        };
      };
      cssls = {
        enable = true;
        config = {
          settings = {
            css.lint.unknownAtRules = "ignore";
            scss.lint.unknownAtRules = "ignore";
            less.lint.unknownAtRules = "ignore";
          };
          on_attach.__raw = ''
            function(client)
              client.server_capabilities.documentFormattingProvider = false
            end
          '';
        };
      };
      tailwindcss.enable = true;
      html.enable = true;
      astro = {
        enable = true;
        config.init_options.typescript.tsdk = "${pkgs.typescript_5}/lib/node_modules/typescript/lib";
      };

      vue_ls.enable = true;
      svelte.enable = true;
      emmet_language_server.enable = true;

      jsonls.enable = true;
      pyright.enable = true;
      taplo.enable = true;
      markdown_oxide = {
        enable = true;
      };
      bashls.enable = true;
      yamlls.enable = true;
      emmylua_ls.enable = true;
    };
  };
  autoCmd = [
    {
      event = "BufWritePre";
      pattern = [
        "*.js"
        "*.jsx"
        "*.ts"
        "*.tsx"
        "*.vue"
        "*.svelte"
      ];
      callback.__raw = ''
        function()
          vim.lsp.buf.code_action({
            context = { only = { "source.fixAll.oxc" } },
            apply = true,
          })
        end
      '';
    }
  ];
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
          add_messages = {
            display_count = true;
            show_multiple_glyphs = false;
          };
          override_open_float = true;
          multilines = {
            enabled = true;
            always_show = true;
            trim_whitespaces = true;
            tabstop = 4;
          };
          show_source.if_many = true;
          break_line = {
            enabled = true;
            after = 80;
          };
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
          stylua.enable = true;
        };

        diagnostics = {
          deadnix.enable = true;
        };

      };
    };
  };
  keymaps =
    let
      cfg = config.plugins;
    in
    [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>cf";
        action.__raw = "function() vim.lsp.buf.format({ async = true }) end";
        options.desc = "Format buffer/selection";
      }
    ]
    ++ lib.optional (cfg.fastaction.enable or false) {
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
  extraPackages = builtins.attrValues {
    inherit (pkgs) nixfmt tsgolint;
  };
}

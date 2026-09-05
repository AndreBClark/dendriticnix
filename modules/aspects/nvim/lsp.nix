{ lib, ... }:
{
  den.aspects.nvim.lsp = {
    homeManager =
      { pkgs, config, ... }:
      let
        cfg = config.programs.nixvim;
      in
      {
        programs.nixvim = {
          lsp = {
            inlayHints.enable = true;
            codelens.enable = true;
            servers = {
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
              astro = {
                enable = true;
                package = pkgs.astro-language-server;
              };
              jsonls.enable = true;
              # phpactor.enable = true;
              svelte.enable = true;
              pyright.enable = true;
              marksman = {
                enable = true;
                config = {
                  markdown = {
                    preferredLinkStyle = "wiki";
                  };
                };
              };
              nixd.enable = true;
              dockerls.enable = true;
              bashls.enable = true;
              yamlls.enable = true;
            };
          };
          plugins = {
            lspconfig.enable = true;
            lsp-format.enable = true;
            lspkind.enable = true;

            fastaction = {
              enable = true;
              settings = {
                register_ui_select = true;
                priority = {
                  default = [
                    {
                      key = "o";
                      order = 1;
                      pattern = "organize import";
                    }
                  ];
                };
              };
            };

            none-ls = {
              enable = true;
              sources = {
                formatting = {
                  nixpkgs_fmt.enable = true;
                  biome.enable = true;
                  stylua.enable = true;
                };

                diagnostics = {
                  statix.enable = true;
                  deadnix.enable = true;
                };

                code_actions = {
                  refactoring.enable = true;
                  statix.enable = true;
                  ts_node_action.enable = true;
                };
              };
            };
            lint.lintersByFt = {
              json = [ "jq" ];
            };
          };
          keymaps = lib.optional (cfg.plugins.fastaction.enable or false) {
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
      };
  };
}

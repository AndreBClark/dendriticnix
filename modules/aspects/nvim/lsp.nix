{
  den.aspects.nvim = {
    provides.lsp = {
      homeManager =
        { pkgs, ... }:
        {
          programs.nixvim = {
            lsp = {
              inlayHints.enable = true;
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
                nixd = {
                  enable = true;
                };
                dockerls.enable = true;
                bashls.enable = true;
                yamlls.enable = true;
              };
            };
            plugins = {
              lspconfig.enable = true;
              lsp-format.enable = true;
              lspkind.enable = true;
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
                    gitsigns.enable = true;
                    statix.enable = true;
                  };
                };
              };
              lint.lintersByFt = {
                json = [ "jq" ];
              };
            };
            extraPackages = [
              pkgs.jq
            ];
          };
        };
    };
  };
}

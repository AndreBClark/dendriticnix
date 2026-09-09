{ den, lib, ... }:
{
  den.aspects.nvim = {
    plugins = {
      includes = builtins.attrValues {
        inherit (den.aspects.nvim)
          barbar
          cmp
          gitsigns
          lualine
          noice
          treesitter
          obsidian
          mini
          snacks
          ;
      };

      homeManager =
        { config, ... }:
        {
          programs.nixvim = {
            plugins = {
              lz-n.enable = true;
              emmet.enable = true;
              glance = {
                enable = true;
                lazyLoad.settings.cmd = "Glance";
              };
              goto-preview = {
                enable = true;
                lazyLoad.settings.keys = [
                  { __unkeyed-1 = "gp"; }
                ];
              };

              cutlass-nvim = {
                enable = true;
                settings = {
                  cut_key = "x";
                  override_del = true;
                };
              };

              illuminate.enable = true;
              nix-develop.enable = true;
              render-markdown.enable = lib.mkDefault true;
              smart-splits = {
                enable = true;
                lazyLoad.settings.keys = [
                  { __unkeyed-1 = "<C-h>"; }
                  { __unkeyed-1 = "<C-j>"; }
                  { __unkeyed-1 = "<C-k>"; }
                  { __unkeyed-1 = "<C-l>"; }
                ];
              };
              kitty-navigator.enable = true;
              trouble = {
                enable = true;
                lazyLoad.settings.cmd = "Trouble";
              };

              web-devicons.enable = true;
              tiny-inline-diagnostic = {
                enable = true;
                settings = {
                  virt_texts = {
                    priority = 2048;
                  };
                };
              };

              refactoring = {
                enable = true;
                enableTelescope = false;
                lazyLoad.settings.keys = [
                  {
                    __unkeyed-1 = "<leader>cr";
                    mode = [
                      "n"
                      "v"
                    ];
                  }
                ];
              };

            };
            keymaps =
              let
                cfg = config.programs.nixvim.plugins;
              in
              (lib.optionals (cfg.glance.enable or false) [
                {
                  mode = "n";
                  key = "gd";
                  action = "<cmd>Glance Definitions<CR>";
                  options.desc = "Peek Definition";
                }
                {
                  mode = "n";
                  key = "gr";
                  action = "<cmd>Glance References<CR>";
                  options.desc = "Peek References";
                }
              ])
              ++ (lib.optional (cfg.goto-preview.enable or false) {
                mode = "n";
                key = "gp";
                action.__raw = "function() require('goto-preview').goto_preview_definition() end";
                options.desc = "Preview Definition";
              })
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
              })
              ++ (lib.optionals (cfg.smart-splits.enable or false) [
                {
                  mode = "n";
                  key = "<C-h>";
                  action.__raw = "function() require('smart-splits').move_cursor_left() end";
                  options.desc = "Move to left split";
                }
                {
                  mode = "n";
                  key = "<C-j>";
                  action.__raw = "function() require('smart-splits').move_cursor_down() end";
                  options.desc = "Move to below split";
                }
                {
                  mode = "n";
                  key = "<C-k>";
                  action.__raw = "function() require('smart-splits').move_cursor_up() end";
                  options.desc = "Move to above split";
                }
                {
                  mode = "n";
                  key = "<C-l>";
                  action.__raw = "function() require('smart-splits').move_cursor_right() end";
                  options.desc = "Move to right split";
                }
              ]);
          };
        };
    };
  };
}

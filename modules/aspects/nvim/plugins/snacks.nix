{ lib, ... }:
{
  den.aspects.nvim.snacks = {
    homeManager =
      { config, ... }:
      {
        programs.nixvim = {
          plugins = {
            snacks = {
              enable = true;
              settings = {
                bufdelete.enabled = true;
                dashboard.enabled = true;
                dim.enabled = true;
                explorer.enabled = true;
                quickfile.enabled = true;
                scroll.enabled = true;
                indent = {
                  enabled = true;
                  indent = {
                    only_scope = true;
                    hl = [
                      "SnacksIndent1"
                      "SnacksIndent2"
                      "SnacksIndent3"
                      "SnacksIndent4"
                      "SnacksIndent5"
                      "SnacksIndent6"
                      "SnacksIndent7"
                      "SnacksIndent8"
                    ];
                  };
                };
                notifier.enabled = true;
                picker = {
                  enabled = true;
                  sources = {
                    explorer.layout.preset = "right";
                    buffers.layout.preset = "right";
                  };

                };
                zen.enabled = true;
                scope.enabled = true;
                rename.enabled = true;
                words.enabled = true;
              };
            };
          };
          dependencies = {
            ripgrep.enable = true;
          };
          keymaps =
            let
              cfg = config.programs.nixvim.plugins.snacks.settings;
            in
            (lib.optional (cfg.explorer.enabled or false) {
              mode = "n";
              key = "<leader>e";
              action.__raw = "function() Snacks.explorer() end";
              options.desc = "File Explorer";
            })
            ++ (lib.optional (cfg.bufdelete.enabled or false) {
              mode = "n";
              key = "<leader>w";
              action.__raw = "function() Snacks.bufdelete() end";
              options.desc = "Delete Buffer";
            })
            ++ (lib.optional (cfg.rename.enabled or false) {
              mode = "n";
              key = "<leader>cR";
              action.__raw = "function() Snacks.rename.rename_file() end";
              options.desc = "Rename File";
            })
            ++ (lib.optional (cfg.notifier.enabled or false) {
              mode = "n";
              key = "<leader>un";
              action.__raw = "function() Snacks.notifier.hide() end";
              options.desc = "Dismiss All Notifications";
            })
            ++ (lib.optional (cfg.terminal.enabled or false) {
              mode = [
                "n"
                "t"
              ];
              key = "<c-/>";
              action.__raw = "function() Snacks.terminal() end";
              options.desc = "Toggle Terminal";
            })
            ++ (lib.optional (cfg.dim.enabled or false) {
              mode = "n";
              key = "<leader>uD";
              action.__raw = ''function() Snacks.toggle.dim():map("<leader>uD") end'';
              options.desc = "Toggle Dim";
            })
            ++ (lib.optional (cfg.indent.enabled or false) {
              mode = "n";
              key = "<leader>ug";
              action.__raw = ''function() Snacks.toggle.indent():map("<leader>ug") end'';
              options.desc = "Toggle Indent Guides";
            })
            ++ (lib.optionals (cfg.words.enabled or false) [
              {
                mode = [
                  "n"
                  "t"
                ];
                key = "]]";
                action.__raw = "function() Snacks.words.jump(vim.v.count1) end";
                options.desc = "Next Reference";
              }
              {
                mode = [
                  "n"
                  "t"
                ];
                key = "[[";
                action.__raw = "function() Snacks.words.jump(-vim.v.count1) end";
                options.desc = "Prev Reference";
              }
            ])
            ++ (lib.optional (cfg.zen.enabled or false) {
              mode = "n";
              key = "<leader>z";
              action.__raw = "function() Snacks.zen() end";
              options.desc = "Toggle Zen Mode";
            })
            ++ (lib.optional (cfg.scratch.enabled or false) {
              mode = "n";
              key = "<leader>.";
              action.__raw = "function() Snacks.scratch() end";
              options.desc = "Toggle Scratch Buffer";
            })
            ++ (lib.optionals (cfg.picker.enabled or false) [
              {
                mode = "n";
                key = "<leader><space>";
                action.__raw = "function() Snacks.picker.smart() end";
                options.desc = "Smart Find Files";
              }
              {
                key = "<leader>sq";
                action.__raw = "function() Snacks.picker.qflist() end";
                options.desc = "Quickfix List";
              }
              {
                mode = "n";
                key = "<leader>fr";
                action.__raw = "function() Snacks.picker.recent() end";
                options.desc = "Recent Files";
              }
              {
                mode = "n";
                key = "<leader>gs";
                action.__raw = "function() Snacks.picker.git_status() end";
                options.desc = "Git Status";
              }
              {
                mode = "n";
                key = "<leader>sd";
                action.__raw = "function() Snacks.picker.diagnostics() end";
                options.desc = "Diagnostics";
              }
              {
                mode = "n";
                key = "<leader>sh";
                action.__raw = "function() Snacks.picker.help() end";
                options.desc = "Help Pages";
              }
              {
                mode = "n";
                key = "<leader>sR";
                action.__raw = "function() Snacks.picker.resume() end";
                options.desc = "Resume Last Picker";
              }
              {
                key = "<leader>sH";
                action.__raw = "function() Snacks.picker.highlights() end";
                options.desc = "Highlights";
              }
              {
                mode = "n";
                key = "<C-p>";
                action.__raw = "function() Snacks.picker.files() end";
                options.desc = "Find Files";
              }
              {
                mode = "n";
                key = "<leader>/";
                action.__raw = "function() Snacks.picker.grep() end";
                options.desc = "Grep";
              }
              {
                mode = "n";
                key = "<leader>,";
                action.__raw = "function() Snacks.picker.buffers() end";
                options.desc = "Buffers";
              }
              {
                mode = "n";
                key = "<leader>sB";
                action.__raw = "function() Snacks.picker.grep_buffers() end";
                options.desc = "Grep Open Buffers";
              }
              {
                mode = [
                  "n"
                  "x"
                ];
                key = "<leader>sw";
                action.__raw = "function() Snacks.picker.grep_word() end";
                options.desc = "Visual selection or word";
              }
              {
                mode = "n";
                key = "<leader>su";
                action.__raw = "function() Snacks.picker.undo() end";
                options.desc = "Undo History";
              }
              {
                mode = "n";
                key = "<leader>ss";
                action.__raw = "function() Snacks.picker.lsp_symbols() end";
                options.desc = "LSP Symbols";
              }
              {
                mode = "n";
                key = "<leader>sS";
                action.__raw = "function() Snacks.picker.lsp_workspace_symbols() end";
                options.desc = "LSP Workspace Symbols";
              }
              {
                mode = "n";
                key = "gr";
                action.__raw = "function() Snacks.picker.lsp_references() end";
                options.desc = "LSP References";
              }
              {
                mode = "n";
                key = "<leader>sk";
                action.__raw = "function() Snacks.picker.keymaps() end";
                options.desc = "Keymaps";
              }
              {
                mode = "n";
                key = "<leader>sz";
                action.__raw = "function() Snacks.picker.zoxide() end";
                options.desc = "Zoxide";
              }
            ]);
        };
      };
  };
}

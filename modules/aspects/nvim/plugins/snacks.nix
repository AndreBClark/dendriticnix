{ lib, ... }:
{
  den.aspects.nvim = {
    snacks = {
      homeManager =
        { config, ... }:
        {
          programs.nixvim = {
            plugins = {
              snacks = {
                enable = true;
                settings = {
                  animate.enable = true;
                  bigFile.enable = true;
                  bufdelete.enabled = true;
                  dim.enabled = true;
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

                  zen.enabled = true;
                  scope.enabled = true;
                  rename.enabled = true;
                  words.enabled = true;
                };
              };
            };

            keymaps =
              let
                cfg = config.programs.nixvim.plugins.snacks.settings;
              in
              (lib.optional (cfg.bufdelete.enabled or false) {
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
              });
          };
        };
    };
    picker-snacks = {
      homeManager =
        { config, ... }:
        {
          programs.nixvim = {
            dependencies = {
              ripgrep.enable = true;
            };
            plugins.snacks = {
              enable = true;
              settings = {
                explorer.enabled = true;
                picker = {
                  enabled = true;
                  sources = {
                    explorer = {
                      layout.preset = "vscode";
                      auto_close = true;
                      jump.close = true;
                      focus = "input";
                    };
                    buffers = {
                      main.current = true;
                      formatters.file = {
                        truncate = "left";
                        min_width = 12;
                        filename_first = true;
                      };
                      layout = {
                        preview = "main";
                        on_show.__raw = ''
                          function(picker)
                            picker:show_preview()
                          end
                        '';
                        layout = {
                          backdrop = false;
                          min_width = 28;
                          width = 0.25;
                          height = 0.3;
                          row = -1;
                          col = -1;
                          position = "float";
                          border = "rounded";
                          box = "vertical";
                          title = "{title} {live} {flags}";
                          title_pos = "center";
                          footer_keys = true;
                          __unkeyed-1 = {
                            win = "input";
                            height = 1;
                            border = "bottom";
                          };
                          __unkeyed-2 = {
                            win = "list";
                            border = "none";
                          };
                        };
                      };
                    };
                  };
                };
              };
            };
            keymaps =
              let
                cfg = config.programs.nixvim.plugins.snacks.settings;
              in
              [
                (lib.optional (cfg.explorer.enabled or false) {
                  mode = "n";
                  key = "<leader>e";
                  action.__raw = "function() Snacks.explorer() end";
                  options.desc = "File Explorer";
                })
                {
                  mode = "n";
                  key = "<leader><space>";
                  action.__raw = "function() Snacks.picker.smart() end";
                  options.desc = "Smart Find Files";
                }
                {
                  key = ''<leader>s"'';
                  action.__raw = "function() Snacks.picker.registers() end";
                  options.desc = "Registers";
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
              ];
          };
        };
    };
  };
}

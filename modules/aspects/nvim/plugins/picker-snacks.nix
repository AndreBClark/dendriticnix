{ lib, ... }:
{
  den.aspects.nvim.picker-snacks = {
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
                    layout = {
                      preset = "vscode";
                      footer_keys = true;
                    };
                    auto_close = true;
                    jump.close = true;
                    focus = "input";
                  };

                  buffers = {
                    main.current = true;
                    formatters.file = {
                      truncate = "left";
                      min_width = 10;
                      filename_first = true;
                    };
                    layout = {
                      preview = "main";
                      layout = {
                        box = "vertical";
                        position = "float";
                        border = "rounded";
                        backdrop = false;
                        width = 0.25;
                        height = 0.3;
                        row = -1;
                        col = -1;
                        # title = "{title} {live} {flags}";
                        # title_pos = "center";
                        footer_keys = true;
                        # __unkeyed-1 = {
                        #   win = "input";
                        #   height = 1;
                        #   border = "bottom";
                        # };
                        # __unkeyed-2 = {
                        #   win = "list";
                        #   border = "none";
                        #   };
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
            ]
            ++ (lib.optional (cfg.explorer.enabled or false) {
              mode = "n";
              key = "<leader>e";
              action.__raw = "function() Snacks.explorer() end";
              options.desc = "File Explorer";
            });
        };
      };
  };
}

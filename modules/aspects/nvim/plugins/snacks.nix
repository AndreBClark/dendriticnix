{ lib, ... }:
{
  den.aspects.nvim.provides.snacks = {
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
                    hl = [ "SnacksIndent1" "SnacksIndent2" "SnacksIndent3" "SnacksIndent4" "SnacksIndent5" "SnacksIndent6" "SnacksIndent7" "SnacksIndent8" ];
                  };
                  scope.underline = true;
                };
                notifier.enabled = true;
                picker = {
                  enabled = true;
                  sources.explorer.layout.layout.position = "right";
                };
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
            (lib.optional (cfg.picker.enabled or false) {
              mode = "n";
              key = "<leader><space>";
              action.__raw = "function() Snacks.picker.smart() end";
              options.desc = "Smart Find Files";
            })
            ++ (lib.optional (cfg.explorer.enabled or false) {
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
            ++ (lib.optional (cfg.gitbrowse.enabled or false) {
              mode = [ "n" "v" ];
              key = "<leader>gB";
              action.__raw = "function() Snacks.gitbrowse() end";
              options.desc = "Git Browse";
            })
            ++ (lib.optional (cfg.lazygit.enabled or false) {
              mode = "n";
              key = "<leader>gg";
              action.__raw = "function() Snacks.lazygit() end";
              options.desc = "Lazygit";
            })
            ++ (lib.optional (cfg.notifier.enabled or false) {
              mode = "n";
              key = "<leader>un";
              action.__raw = "function() Snacks.notifier.hide() end";
              options.desc = "Dismiss All Notifications";
            })
            ++ (lib.optional (cfg.terminal.enabled or false) {
              mode = [ "n" "t" ];
              key = "<c-/>";
              action.__raw = "function() Snacks.terminal() end";
              options.desc = "Toggle Terminal";
            })
            ++ (lib.optionals (cfg.words.enabled or false) [
              { mode = [ "n" "t" ]; key = "]]"; action.__raw = "function() Snacks.words.jump(vim.v.count1) end"; options.desc = "Next Reference"; }
              { mode = [ "n" "t" ]; key = "[["; action.__raw = "function() Snacks.words.jump(-vim.v.count1) end"; options.desc = "Prev Reference"; }
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
            ++ (lib.optional (cfg.picker.enabled or false) {
              mode = "n";
              key = "<leader>fc";
              action.__raw = ''function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end'';
              options.desc = "Find Config File";
            })
            ++ (lib.optional (cfg.picker.enabled or false) {
              mode = "n";
              key = "<leader>fr";
              action.__raw = "function() Snacks.picker.recent() end";
              options.desc = "Recent Files";
            })
            ++ (lib.optional (cfg.picker.enabled or false) {
              mode = "n";
              key = "<leader>gs";
              action.__raw = "function() Snacks.picker.git_status() end";
              options.desc = "Git Status";
            })
            ++ (lib.optional (cfg.picker.enabled or false) {
              mode = "n";
              key = "<leader>sd";
              action.__raw = "function() Snacks.picker.diagnostics() end";
              options.desc = "Diagnostics";
            })
            ++ (lib.optional (cfg.picker.enabled or false) {
              mode = "n";
              key = "<leader>sh";
              action.__raw = "function() Snacks.picker.help() end";
              options.desc = "Help Pages";
            })
            ++ (lib.optional (cfg.picker.enabled or false) {
              mode = "n";
              key = "<leader>sR";
              action.__raw = "function() Snacks.picker.resume() end";
              options.desc = "Resume Last Picker";
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
            ++ (lib.optionals (cfg.picker.enabled or false) [
              { mode = "n"; key = "<C-p>"; action.__raw = "function() Snacks.picker.files() end"; options.desc = "Find Files"; }
              { mode = "n"; key = "<leader>/"; action.__raw = "function() Snacks.picker.grep() end"; options.desc = "Grep"; }
              { mode = "n"; key = "<leader>,"; action.__raw = "function() Snacks.picker.buffers() end"; options.desc = "Buffers"; }
              { mode = "n"; key = "<leader>sB"; action.__raw = "function() Snacks.picker.grep_buffers() end"; options.desc = "Grep Open Buffers"; }
              { mode = [ "n" "x" ]; key = "<leader>sw"; action.__raw = "function() Snacks.picker.grep_word() end"; options.desc = "Visual selection or word"; }
              { mode = "n"; key = "<leader>su"; action.__raw = "function() Snacks.picker.undo() end"; options.desc = "Undo History"; }
            ]);

        };
      };
  };
}

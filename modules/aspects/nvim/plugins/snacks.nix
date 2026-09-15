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
  };
}

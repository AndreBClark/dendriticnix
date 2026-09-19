{ den, ... }:
{
  den.aspects.nvim = {
    includes = [
      (den.batteries.unfree [ "barbar.nvim" ])
    ];

    barbar = {
      nixvim = {
        plugins = {
          web-devicons.enable = true;

          barbar = {
            enable = true;
            settings = {
              animation = true;
              auto_hide = 1;
              clickable = true;
              tabpages = true;
              icons = {
                preset = "powerline";
                button = false;
                buffer_index = true;
                current = {
                  gitsigns = {
                    added.enabled = true;
                    changed.enabled = true;
                    deleted.enabled = true;
                  };
                };
                diagnostics = {
                  "vim.diagnostic.severity.ERROR".enabled = true;
                  "vim.diagnostic.severity.WARN".enabled = true;
                };

              };
              modified.button = "●";
              pinned = {
                filename = true;
              };

              focus_on_close = "left";
              insert_at_end = true;
              maximum_padding = 2;
              minimum_padding = 1;
              semantic_letters = true;
              letters = "asdfjkl;ghnmxcvbziowerutyqp";

              sidebar_filetypes = {
                snacks_picker_list = true;
                NvimTree = true;
              };
            };

            keymaps = {
              next.key = "<Tab>";
              previous.key = "<S-Tab>";
              pin.key = "<leader>bp";
              close = {
                key = "<leader>bd";
                options.desc = "Close buffer";
              };
              pick = {
                key = "<leader>bb";
                options.desc = "Pick buffer";
              };
              closeAllButCurrentOrPinned.key = "<leader>bo";
              orderByDirectory.key = "<leader>bsd";
              orderByLanguage.key = "<leader>bsl";
              goTo1.key = "<leader>1";
              goTo2.key = "<leader>2";
              goTo3.key = "<leader>3";
              goTo4.key = "<leader>4";
              goTo5.key = "<leader>5";
              movePrevious.key = "<leader>b<";
              moveNext.key = "<leader>b>";
            };
          };
        };
      };
    };
  };
}

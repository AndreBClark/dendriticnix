{ lib, config, ... }:
{
  plugins = {
    emmet.enable = true;
    modicator = {
      enable = true;
      settings = {
        integration.lualine = {
          enabled = true;
          highlight = "bg";
        };
      };
    };

    goto-preview.enable = true;

    cutlass-nvim = {
      enable = true;
      settings = {
        cut_key = "x";
        override_del = true;
      };
    };

    nix-develop.enable = true;
    render-markdown.enable = lib.mkDefault true;
    smart-splits.enable = true;
    kitty-navigator.enable = true;
    trouble.enable = true;

    web-devicons.enable = true;
    tiny-inline-diagnostic = {
      enable = true;
      settings.virt_texts.priority = 2048;
    };

    refactoring = {
      enable = true;
      enableTelescope = false;
    };
  };

  keymaps =
    let
      cfg = config.plugins;
    in
    (lib.optional (cfg.goto-preview.enable or false) {
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
}

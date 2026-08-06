{ lib, ... }:
{
  globals.mapleader = lib.mkDefault " ";
  keymaps = [
    {
      key = ";";
      action = ":";
      options.desc = "Enter command mode";
    }
    {
      key = "<space>";
      action = "";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>Bdelete<CR>";
      options.desc = "Delete buffer";
    }
    {
      key = "<leader>q";
      mode = "n";
      action = "<cmd>close<cr>";
      options.desc = "close split";
    }
    {
      key = "<leader>-";
      mode = "n";
      action = "<cmd>split<CR>";
      options.desc = "horizontal split buffer";
    }
    {
      key = "<leader>\\";
      mode = "n";
      action = "<cmd>vsplit<CR>";
      options.desc = "vertical split buffer";
    }

    {
      mode = "n";
      key = "zR";
      action = "<cmd>lua require('ufo').openAllFolds()<cr>";
      options = {
        desc = "Open all folds";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "zM";
      action = "<cmd>lua require('ufo').closeAllFolds()<cr>";
      options = {
        desc = "Close all folds";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<C-p>";
      action = "<cmd>FzfLua files<CR>";
      options = {
        desc = "FZF file search";
        silent = true;
      };
    }
  ];
  plugins = {
    lsp.keymaps = {
      lspBuf = {
        "gd" = "definition";
        "gD" = "references";
        "K" = "hover";
        "gi" = "implementation";
      };
    };

  };
}

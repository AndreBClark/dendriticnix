{ lib, ... }:
{
  den.aspects.nvim = {
    provides.keymaps = {
      homeManager = {
        programs.nixvim = {
          userCommands = {
            W.command = "w";
            Q.command = "q";
          };
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
              key = "<C-p>";
              action = "<cmd>FzfLua files<CR>";
              options = {
                desc = "FZF file search";
                silent = true;
              };
            }
          ];
        };
      };
    };
  };
}

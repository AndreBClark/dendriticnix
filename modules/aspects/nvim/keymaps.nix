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
              key = "<C-a>";
              action = "ggVG";
              options.desc = "Select all";
            }

          ];
        };
      };
    };
  };
}

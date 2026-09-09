{ lib, ... }:
{
  den.aspects.nvim.keymaps = {
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
            mode = [
              "n"
              "v"
            ];
            key = "<leader>a";
            action = "ggV$G";
            options.desc = "Select all";
          }
          {
            key = "<ScrollWheelLeft>";
            action = "<Nop>";
            mode = [
              "n"
              "i"
              "v"
            ];
          }
          {
            key = "<ScrollWheelRight>";
            action = "<Nop>";
            mode = [
              "n"
              "i"
              "v"
            ];
          }
        ];
        plugins.which-key = {
          enable = true;
          settings = {
            preset = "modern";
            layout = {
              spacing = 5;
              width = {
                min = 40;
                max = 80;
              };
            };
            spec = [
              {
                __unkeyed-1 = "<leader>f";
                group = "Find";
                icon = "󰈞 ";
              }
              {
                __unkeyed-1 = "<leader>g";
                group = "Git";
                icon = "󰊢 ";
              }
              {
                __unkeyed-1 = "<leader>x";
                group = "Diagnostics/Trouble";
                icon = "󰀪 ";
              }
              {
                __unkeyed-1 = "<leader>s";
                group = "Search";
                icon = "󰍉 ";
              }
              {
                __unkeyed-1 = "<leader>c";
                group = "Code";
                icon = "󰅩 ";
              }
              {
                __unkeyed-1 = "<leader>u";
                group = "UI/Toggles";
                icon = "󰙵 ";
              }
              {
                __unkeyed-1 = "<leader>o";
                group = "Obsidian";
                icon = "󱓧 ";
              }
              {
                __unkeyed-1 = "<leader>b";
                group = "Buffer";
                icon = "󰓩 ";
              }
            ];
          };
        };
      };
    };
  };
}

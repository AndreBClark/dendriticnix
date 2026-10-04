{ lib, ... }:
{
  userCommands = {
    W.command = "wall";
    Q.command = "qall";
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
      action = "<Nop>";
      options.silent = true;
    }
    {
      key = "<MiddleMouse>";
      action = "<Nop>";
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
      key = "<leader>aa";
      action = "gg0vG$v";
      options.desc = "Select All Buffer Contents";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>ay";
      action = "<cmd>%y<CR>";
      options.desc = "Yank Buffer Contents";
    }
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>ad";
      action = "<cmd>%d<CR>";
      options.desc = "Delete Buffer Contents";
    }
  ];
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "modern";
      filter.__raw = ''
        function(mapping)
          return not require("which-key.util").is_nop(mapping.rhs)
        end
      '';
      # ── smaller window ──
      win = {
        height = {
          min = 4;
          max = 10;
        }; # cap total popup height
        padding = [
          0
          1
        ]; # was default {1,2}; saves 2 rows
        no_overlap = true;
        title = false; # drop title row/border
      };
      show_help = false; # removes the "+1" help line
      show_keys = false; # breadcrumb still shows in title if enabled

      layout = {
        spacing = 2;
        width = {
          min = 30;
          max = 60;
        }; # narrower columns → more columns → fewer rows
      };

      # ── QoL ──
      delay = 100; # you have timeoutlen=300; popup can be snappier
      expand = 1; # auto-expand groups with <=1 mapping
      sort = [
        "local"
        "order"
        "alphanum"
        "group"
        "mod"
      ];
      icons.rules = [ ]; # rely on defaults + your devicons/mini.icons

      spec = [
        {
          __unkeyed-1 = "<leader>a";
          group = "All/Buffer";
        } # you already have aa/ay/ad
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
          # dynamic buffer switcher: <leader>b1..9 jumps to a buffer
          expand.__raw = ''function() return require("which-key.extras").expand.buf() end'';
        }
        {
          __unkeyed-1 = "<leader>w";
          proxy = "<c-w>";
          group = "windows";
        }
      ];
    };
  };
}

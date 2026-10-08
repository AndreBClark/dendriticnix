{ lib, config, ... }:
{
  userCommands = {
    W.command = "wall";
    Q.command = "qall";
    WQ.command = "wqall";
    QW.command = "wqall";
    Qw.command = "wq";
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
      action = "gg0vG$";
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
  ]
  ++ (lib.optional config.plugins.toggler.enable or false {
    mode = [
      "n"
      "v"
    ];
    key = "<leader>ci";
    action.__raw = "require('nvim-toggler').toggle";
    options = {
      desc = "Invert Boolean value";
      silent = true;
    };
  });
}

{
  plugins = {
    gitsigns = {
      enable = true;
      settings = {
        signcolumn = false;
        numhl = true;
        linehl = true;
        current_line_blame = true;
        current_line_blame_opts = {
          ignore_whitespace = true;
        };
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>gr";
      action = "<cmd>Gitsigns reset_hunk<CR>";
      options = {
        silent = true;
        desc = "Reset hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>ga";
      action = "<cmd>Gitsigns stage_hunk<CR>";
      options = {
        silent = true;
        desc = "Stage hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>gu";
      action = "<cmd>Gitsigns undo_stage_hunk<CR>";
      options = {
        silent = true;
        desc = "Undo stage hunk";
      };
    }
    {
      mode = "n";
      key = "]h";
      action.__raw = "function() require('gitsigns').nav_hunk('next') end";
      options = {
        silent = true;
        desc = "Next hunk";
      };
    }
    {
      mode = "n";
      key = "[h";
      action.__raw = "function() require('gitsigns').nav_hunk('prev') end";
      options = {
        silent = true;
        desc = "Prev hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>gb";
      action = "<cmd>Gitsigns blame_line<CR>";
      options = {
        silent = true;
        desc = "Blame line";
      };
    }
    {
      mode = "n";
      key = "<leader>gp";
      action = "<cmd>Gitsigns preview_hunk_inline<CR>";
      options = {
        silent = true;
        desc = "Preview hunk inline";
      };
    }
  ];
}

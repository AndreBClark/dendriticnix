{
  plugins = {
    gitsigns = {
      enable = true;
      settings = {
        signcolumn = true;
        numhl = false;
        current_line_blame = true;
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
  ];
}

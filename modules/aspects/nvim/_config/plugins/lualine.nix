{
  plugins = {
    lualine = {
      enable = true;
      settings = {
        options = {
          section_separators = {
            left = "";
            right = "";
          };
          extensions = [
            "fzf"
            "nvim-tree"
            "toggleterm"
          ];
        };
      };
    };
  };
  highlight = {
    LualineMode.bold = true;
    LualineBranch.bold = true;
    LualineFilename.bold = true;
  };
}

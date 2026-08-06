{
  plugins = {
    nvim-tree = {
      enable = true;
      ignoreFtOnSetup = [
        "startify"
        "alpha"
        "dashboard"
      ];
      autoClose = false; # Prevent buffer naming conflicts
      settings = {
        view = {
          side = "right";
        };

        filesystem_watchers = {
          enable = true;
          ignore_dirs = [
            "node_modules"
            ".git"
            "target"
            "dist"
          ];
        };

        git = {
          enable = true;
          ignore = true;
          show_on_dirs = true;
          timeout = 200;
        };

        renderer = {
          highlight_git = true;
          highlight_opened_files = "all";
          highlight_modified = "all";
          group_empty = true;
          indent_markers = {
            enable = true;
          };
          icons = {
            show = {
              git = true;
              modified = true;
            };
          };
        };

        filters = {
          custom = [
            "*.o"
            "*.pyc"
            "__pycache__"
          ];
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>NvimTreeToggle<CR>";
      options.desc = "Toggle File Tree";
    }
  ];
}

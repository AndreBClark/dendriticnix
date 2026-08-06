{
  plugins = {
    noice = {
      enable = true;
      settings = {
        # Enable cmdline UI with popup view
        cmdline = {
          enabled = true;
          view = "cmdline_popup";
        };

        # Enable messages UI
        messages = {
          enabled = true;
          view = "notify";
        };

        # Enable popupmenu UI
        popupmenu = {
          enabled = true;
          backend = "nui";
        };

        # Enable LSP features
        lsp = {
          progress = {
            enabled = true;
            view = "mini";
          };
          hover = {
            enabled = true;
          };
          signature = {
            enabled = true;
          };
        };

        # Enable notifications
        notify = {
          enabled = true;
          view = "notify";
        };
      };
    };
  };
}

{
  den.aspects.nvim.noice = {
    homeManager = {
      programs.nixvim = {
        plugins = {
          noice = {
            enable = true;
            settings = {
              cmdline = {
                enabled = true;
                view = "cmdline_popup";
              };

              messages = {
                enabled = true;
                view = "mini";
              };

              popupmenu = {
                enabled = true;
                backend = "nui";
              };

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

              notify = {
                enabled = false;
                view = "notify";
              };
            };
          };
        };
      };
    };
  };
}

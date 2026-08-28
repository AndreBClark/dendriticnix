{
  den.aspects.nvim = {
    lualine = {
      homeManager = {
        programs.nixvim.plugins = {
          lualine = {
            enable = true;
            settings =
              let
                separator = {
                  left = "";
                  right = "";
                };
              in
              {
                options = {
                  component_separators = "";
                  section_separators = {
                    left = separator.right;
                    right = separator.left;
                  };
                  globalstatus = true;
                };

                sections = {
                  lualine_a = [
                    {
                      inherit separator;
                      __unkeyed-1 = "mode";
                      color = {
                        gui = "bold";
                      };
                    }
                  ];
                  lualine_b = [
                    "branch"
                    "diff"
                  ];
                  lualine_c = [
                    {
                      __unkeyed-1 = "filename";
                      path = 3;
                    }
                    "diagnostics"
                  ];
                  lualine_x = [
                    "encoding"
                    {
                      __unkeyed-1 = "fileformat";
                      icons_enabled = true;
                      symbols = {
                        unix = "";
                        dos = "CRLF";
                        mac = "CR";
                      };
                    }
                  ];
                  lualine_y = [
                    "filetype"
                    {
                      __unkeyed-1 = "lsp_status";
                      padding = {
                        left = 0;
                        right = 1;
                      };
                      icon = "";
                      ignore_lsp = [ "null-ls" ];
                    }
                  ];
                  lualine_z = [
                    {
                      inherit separator;
                      padding = 0;
                      __unkeyed-1 = "location";
                      color.gui = "bold";
                    }
                  ];
                };

              };
          };
        };
      };
    };
  };
}

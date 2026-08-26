{
  den.aspects.nvim = {
    lualine = {
      homeManager = {
        programs.nixvim.plugins = {
          lualine = {
            enable = true;
            settings =
              let
                # Powerline "pill" glyphs (Nerd Font, U+E0B6 / U+E0B4)
                pillLeft = "";
                pillRight = "";
              in
              {
                options = {
                  component_separators = "";
                  section_separators = {
                    left = pillLeft;
                    right = pillRight;
                  };
                  globalstatus = true;
                };

                sections = {
                  lualine_a = [
                    {
                      __unkeyed-1 = "mode";
                      separator = {
                        left = pillRight;
                        right = pillLeft;
                      };
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
                    "filename"
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
                    "lsp_status"
                  ];
                  lualine_z = [
                    {
                      __unkeyed-1 = "location";
                      separator.right = pillLeft;
                      gui = "bold";
                    }
                  ];
                };

                inactive_sections = {
                  lualine_x = [ "location" ];
                };
              };
          };
        };
      };
    };
  };
}

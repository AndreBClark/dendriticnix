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
                      gui = "bold";
                    }
                  ];
                  lualine_b = [
                    "branch"
                    "diff"
                  ];
                  lualine_c = [
                    "filename"
                  ];
                  lualine_x = [
                    "diagnostics"
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
                    "filetype"
                  ];
                  lualine_y = [ "progress" ];
                  lualine_z = [
                    {
                      __unkeyed-1 = "location";
                      separator.right = pillLeft;
                    }
                  ];
                };

                inactive_sections = {
                  lualine_c = [ "filename" ];
                  lualine_x = [ "location" ];
                };
              };
          };
        };
      };
    };
  };
}

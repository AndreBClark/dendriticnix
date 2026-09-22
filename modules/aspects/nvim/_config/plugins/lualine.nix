{
  plugins = {
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
                padding = 0;
                color.gui = "bold";
              }
            ];

            lualine_b = [
              "branch"
              "diff"
            ];

            lualine_c = [
              {
                __unkeyed-1 = "filetype";
                icon_only = true;
                padding = {
                  left = 1;
                  right = 0;
                };
              }
              {
                __unkeyed-1 = "filename";
                path = 4;
                padding.left = 0;
              }
              "diagnostics"
            ];

            lualine_x = [
              {
                __unkeyed-1 = "encoding";
                cond.__raw = ''function() return vim.bo.fileencoding ~= "" and vim.bo.fileencoding ~= "utf-8" end'';
              }
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
          inactive_sections = {
            lualine_a = [
              "mode"
            ];
          };
        };
    };
  };
}

{
  den.aspects.nvim = {
    lualine = {
      homeManager =
        { config, ... }:
        {
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

                  sections =
                    let
                      colors = config.lib.stylix.colors.withHashtag;
                      dummyComponent = {
                        __unkeyed-1 = "";
                        draw_empty = true;
                        separator = "";
                        color.bg = colors.base00;
                      };
                    in
                    {
                      lualine_a = [
                        dummyComponent
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
                          __unkeyed-1 = "filename";
                          path = 3;
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
                        dummyComponent
                      ];
                    };

                };
            };
          };
        };
    };
  };
}

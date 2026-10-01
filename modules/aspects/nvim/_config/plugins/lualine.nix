{ config, ... }:
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
          colors = config.colorschemes.base16.colorscheme;
        in
        {
          options = {
            theme.__raw = ''
              (function()
                local base = require("lualine.themes.base16")
                local c = require("base16-colorscheme").colors
                base.command = { a = { fg = c.base00, bg = c.base0C, gui = "bold" } }
                return base
              end)()
            '';
            component_separators = "";
            section_separators = {
              left = separator.right;
              right = separator.left;
            };
            globalstatus = true;
            disabled_filetypes = [
              "snacks_picker"
              "snacks_dashboard"
              "snacks_explorer"
              "trouble"
              "qf"
              "blink-cmp-menu"
              "blink-cmp-documentation"
              "blink-cmp-signature"
            ];
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
          winbar.lualine_c =
            let
              colorActive = {
                fg = colors.base02;
                bg = colors.base0C;
                gui = "bold";
              };
            in
            [
              {
                inherit separator;
                __unkeyed-1 = "filetype";
                icon_only = true;
                padding = 0;
                color = {
                  bg = colorActive.fg;
                  gui = "bold";
                };
              }
              {
                separator = { inherit (separator) right; };
                padding = 1;
                path = 4;
                __unkeyed-1 = "filename";
                color = colorActive;
              }
            ];

          inactive_winbar.lualine_c =
            let
              colorInactive = {
                fg = colors.base02;
                bg = colors.base01;
              };
            in
            [
              {
                inherit separator;
                __unkeyed-1 = "filetype";
                icon_only = true;
                padding = 0;
                color = {
                  bg = colorInactive.fg;
                  gui = "bold";
                };
              }
              {
                separator = { inherit (separator) right; };
                padding = 1;
                path = 4;
                __unkeyed-1 = "filename";
                color = colorInactive;
              }
            ];
        };
    };
  };
}

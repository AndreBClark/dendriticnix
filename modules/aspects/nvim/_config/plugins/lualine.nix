{ config, pkgs, ... }:
let
  colors = config.colorschemes.base16.colorscheme;
  sources = import ../../../../../npins;
in
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
          separator_flipped = {
            left = "";
            right = "";
          };
        in
        {
          options = {
            theme.__raw = ''
              (function()
                local base = require("lualine.themes.base16")
                local c = require("base16-colorscheme").colors
                base.command = { a = { fg = c.base00, bg = c.base0C, gui = "bold" } }
                _G.mk_mode_color = function(target)
                  return function()
                    local theme = require("lualine.themes.base16")
                    local m = require("lualine.utils.mode").get_mode()
                    local map = {
                      NORMAL = theme.normal, INSERT = theme.insert, VISUAL = theme.visual,
                      ["V-LINE"] = theme.visual, ["V-BLOCK"] = theme.visual,
                      COMMAND = theme.command, REPLACE = theme.replace,
                      TERMINAL = theme.terminal or theme.normal,
                    }
                    local hl = (map[m] or theme.normal).a
                    if target == "bg" then
                      return { fg = hl.fg, bg = hl.bg, gui = "bold" }  -- pill
                    else
                      return { fg = hl.bg } -- tinted text
                    end
                  end
                end
                for _, mode in pairs(base) do
                  if mode.a then
                    mode.c = { fg = mode.a.fg, bg = mode.a.bg }
                  end
                end
                return base
              end)()
            '';
            section_separators = separator_flipped;
            component_separators = "";
            always_divide_middle = false;
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
            ignore_focus = [
              "snacks_picker"
              "snacks_explorer"
              "snacks_dashboard"
            ];
          };
          extensions = [ "trouble" ];

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
              {
                __unkeyed-1 = "branch";
                color.__raw = ''_G.mk_mode_color("fg")'';
              }
              "diff"
            ];

            lualine_c = [
              {
                separator = {
                  inherit (separator) right;
                };
                __unkeyed-1 = "buffers";
                use_mode_colors = true;
              }
            ];
            lualine_x = [
              {
                inherit (separator) left;
                __unkeyed-1 = "%=";
                color.__raw = ''_G.mk_mode_color("bg")'';
              }
              {
                __unkeyed-1 = "encoding";
                cond.__raw = ''function() return vim.bo.fileencoding ~= "" and vim.bo.fileencoding ~= "utf-8" end'';
                color.__raw = ''_G.mk_mode_color("fg")'';
              }
              {
                __unkeyed-1 = "fileformat";
                icons_enabled = true;
                symbols = {
                  unix = "";
                  dos = "CRLF";
                  mac = "CR";
                };
                color.__raw = ''_G.mk_mode_color("fg")'';
              }
            ];

            lualine_y = [
              {
                __unkeyed-1 = "searchcount";
                maxcount = 999;
                timeout = 500;
                color.__raw = ''_G.mk_mode_color("fg")'';
              }
              "diagnostics"
              {
                __unkeyed-1 = "lsp_status";
                padding = {
                  left = 0;
                  right = 1;
                };
                icon = "";
                ignore_lsp = [ "null-ls" ];
                color.__raw = ''_G.mk_mode_color("fg")'';
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
          winbar.lualine_c = [
            {
              __unkeyed-1.__raw = ''function() return " " end'';
              padding = 0;
              draw_empty = true;
              color = "WinBar";
            }
            {
              __unkeyed-1 = "filetype";
              inherit separator;
              icon_only = true;
              padding = 1;
              color = {
                bg = colors.base02;
                fg = colors.base0C;
              };
            }
            {
              __unkeyed-1 = "filename";
              separator = { inherit (separator) right; };
              padding = 1;
              path = 4;
              color.__raw = ''_G.mk_mode_color("bg")'';
            }

          ];

          inactive_winbar.lualine_c =
            let
              colorInactive = {
                fg = colors.base04;
                bg = colors.base01;
              };
            in
            [
              {
                inherit separator;
                __unkeyed-1 = "filetype";
                icon_only = true;
                padding = 1;
                color = {
                  inherit (colorInactive) bg;
                };
              }
              {
                __unkeyed-1 = "filename";
                separator = { inherit (separator) right; };
                padding = 1;
                path = 4;
                color = colorInactive;
              }

            ];
        };
    };

  };
  extraPlugins =
    let
      moodyConfig =
        with colors;
        # lua
        ''
          local blend = { dark = 0.5, bright = 0.8, base = 0.75 }
          require("moody").setup({
            blends = {
              insert = blend.dark,
              visual = blend.bright,
              normal = blend.base,
              command = blend.bright,
              operator = blend.bright,
              replace = blend.dark,
              select = blend.bright,
            },

            colors = {
              normal = "${base0D}",
              insert = "${base0B}",
              visual = "${base0E}",
              command = "${base0C}",
              operator = "${base0C}",
              replace = "${base09}",
              select = "${base0E}",
              terminal = "${base0C}",
              terminal_n = "${base0D}"
            },
            bold_line_number = true,
            recording = { enabled = true },
            column = { enabled = false }
          })
        '';
    in
    [
      (pkgs.vimUtils.buildVimPlugin {
        name = "moody.nvim";
        src = sources.moody-nvim;
        nvimSkipModules = [ "moody.statuscolumn" ];
        postInstall = ''
          substituteInPlace $out/lua/moody/utils.lua --replace-fail \
          'name = "Normal"' 'name = "CursorLine"'
          substituteInPlace $out/lua/moody/config.lua --replace-fail \
            '["r"] = "ns_replace",' \
            '["r"] = "ns_replace", ["R"] = "ns_replace", ["Rv"] = "ns_replace", ["Rc"] = "ns_replace", ["Rx"] = "ns_replace",'
          rm $out/plugin/moody.vim
          cat > $out/plugin/moody.lua <<'EOF'
          ${moodyConfig}
          EOF
        '';
      })
    ];
}

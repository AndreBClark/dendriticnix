{
  plugins = {
    bufferline = {
      enable = true;
      settings = {
        options = {
          buffer_close_icon = "󰅖";
          indicator = {
            style = "icon";
            icon = "▎";
          };
          separator_style = "thick";
          max_name_length = 20;
          tab_size = 20;
          diagnostics = "nvim_lsp";
          diagnostics_indicator =
            # Lua
            ''
              function(count, level, diagnostics_dict, context)
                local s = ""
                for e, n in pairs(diagnostics_dict) do
                  local sym = e == "error" and " "
                    or (e == "warning" and " " or "" )
                  if(sym ~= "") then
                    s = s .. " " .. n .. sym
                  end
                end
                return s
              end
            '';
          sort_by = "insert_after_current";
          offsets = [
            {
              filetype = "nvim-tree";
              text = "File Explorer";
              text_align = "center";
              highlight = "Directory";
            }
          ];
        };
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<cr>";
      options.desc = "Cycle to next buffer";
    }
    {
      mode = "n";
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<cr>";
      options.desc = "Cycle to previous buffer";
    }
  ];
}

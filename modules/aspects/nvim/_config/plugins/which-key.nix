{
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "modern";
      filter.__raw = ''
        function(mapping)
          return not require("which-key.util").is_nop(mapping.rhs)
        end
      '';
      # ── smaller window ──
      win = {
        height = {
          min = 4;
          max = 10;
        }; # cap total popup height
        padding = [
          0
          1
        ]; # was default {1,2}; saves 2 rows
        no_overlap = true;
        title = true; # drop title row/border
      };
      show_help = true; # removes the "+1" help line
      show_keys = true; # breadcrumb still shows in title if enabled

      layout = {
        spacing = 2;
        width = {
          min = 30;
          max = 60;
        }; # narrower columns → more columns → fewer rows
      };

      # ── QoL ──
      delay = 100; # you have timeoutlen=300; popup can be snappier
      expand = 1; # auto-expand groups with <=1 mapping
      sort = [
        "local"
        "order"
        "alphanum"
        "group"
        "mod"
      ];

      spec = [
        {
          __unkeyed-1 = "<leader>a";
          group = "Grab Buffer";
        }
        {
          __unkeyed-1 = "<leader>g";
          group = "Git";
          icon = "󰊢 ";
        }
        {
          __unkeyed-1 = "<leader>x";
          group = "Diagnostics/Trouble";
          icon = "󰀪 ";
        }
        {
          __unkeyed-1 = "<leader>s";
          group = "Search";
          icon = "󰍉 ";
        }
        {
          __unkeyed-1 = "<leader>c";
          group = "Code";
          icon = "󰅩 ";
        }
        {
          __unkeyed-1 = "<leader>u";
          group = "UI/Toggles";
          icon = "󰙵 ";
        }
        {
          __unkeyed-1 = "<leader>o";
          group = "Obsidian";
          icon = "󱓧 ";
        }
        {
          __unkeyed-1 = "<leader>b";
          group = "Buffer";
          icon = "󰓩 ";
          expand.__raw = ''function() return require("which-key.extras").expand.buf() end'';
        }
        {
          __unkeyed-1 = "<leader>w";
          proxy = "<c-w>";
          group = "windows";
        }
      ];
    };
  };
}

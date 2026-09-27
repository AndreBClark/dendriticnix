{
  plugins = {
    blink-cmp = {
      enable = true;
      setupLspCapabilities = true;
      settings = {
        keymap = {
          preset = "super-tab";
          "<C-space>" = [
            "show"
            "show_documentation"
            "hide_documentation"
          ];
          "<C-b>" = [
            "scroll_documentation_up"
            "fallback"
          ];
          "<C-f>" = [
            "scroll_documentation_down"
            "fallback"
          ];
        };
        signature = {
          enabled = true;
          window.border = "rounded";
        };
        snippets.preset = "mini_snippets";
        appearance.nerd_font_variant = "normal";
        fuzzy.sorts = [
          "exact"
          "score"
          "sort_text"
          "label"
        ];
        completion = {
          ghost_text.enabled = true;
          keyword.range = "full";
          menu = {
            border = "rounded";
            auto_show = true;
            draw = {
              treesitter = [ "lsp" ];
              columns = [
                [ "kind_icon" ]
                {
                  __unkeyed-1 = "label";
                  __unkeyed-2 = "label_description";
                  gap = 1;
                }
                [ "source_name" ]
              ];
            };
          };

          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
            window.border = "rounded";
          };
          accept.auto_brackets = {
            enabled = true;
            semantic_token_resolution.enabled = true;
          };
        };
        cmdline = {
          keymap.preset = "inherit";
          completion.menu.auto_show = true;
        };
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
            "ripgrep"
          ];
          per_filetype = {
            markdown = [
              "lsp"
              "path"
              "snippets"
              "buffer"
              "spell"
            ];
            text = [
              "buffer"
              "spell"
            ];
          };
          providers = {
            lsp = {
              score_offset = 10;
              transform_items.__raw = ''
                function(_, items)
                  local kinds = require('blink.cmp.types').CompletionItemKind
                  for _, item in ipairs(items) do
                    if item.kind == kinds.Snippet then
                      item.score_offset = item.score_offset - 5
                    end
                  end
                  return vim.tbl_filter(function(item)
                    return item.kind ~= kinds.Text
                  end, items)
                end
              '';
            };
            snippets.score_offset = 5;
            path.score_offset = 3;
            buffer = {
              score_offset = -5;
              min_keyword_length = 3;
            };
            ripgrep = {
              name = "Ripgrep";
              module = "blink-ripgrep";
              score_offset = -10;
              max_items = 20;
              opts = {
                prefix_min_len = 4;
                max_filesize = "1M";
              };
            };
            spell = {
              name = "Spell";
              module = "blink-cmp-spell";
              score_offset = -5; # below buffer in prose buffers
              max_items = 5;
              opts.keep_all_entries = false;
            };
          };
        };
      };
    };
    blink-cmp-spell.enable = true;
    blink-ripgrep.enable = true;
    mini-snippets.enable = true;
  };
}

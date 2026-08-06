{
  plugins = {
    obsidian = {
      enable = true;
      settings = {
        legacy_commands = false;
        templates = {
          subdir = "templates";
          substitutions = {
            display_title.__raw = ''
              function()
                local client = require("obsidian").get_client()
                local note = require("obsidian.note").from_buffer(0)
                return note.metadata.display_title or note.title or ""
              end
            '';
          };
        };
        ui.enable = true;
        workspaces = [
          {
            name = "coursenotes";
            path = "~/vaults/coursenotes";
          }
        ];
        note_id_func.__raw = ''
          function(title)
            -- Just return the title, no numbering here
            local title_suffix = ""
            if title ~= nil then
              title_suffix = title:gsub(" ", "_"):gsub("[^A-Za-z0-9_]", ""):lower()
            else
              title_suffix = "note"
            end
            return title_suffix
          end
        '';
        note_path_func.__raw = ''
          function(spec)
            -- Get all existing .md files in the target directory
            local files = vim.fn.glob(tostring(spec.dir) .. "/*.md", false, true)
            local max_num = 0

            -- Find the highest existing number
            for _, file in ipairs(files) do
              local filename = vim.fn.fnamemodify(file, ":t:r")
              local num = filename:match("^(%d+)_")
              if num then
                max_num = math.max(max_num, tonumber(num))
              end
            end

            -- Always start from 01 if no files exist, or increment
            local next_num = string.format("%02d_", max_num + 1)

            -- Combine number and title
            local filename = next_num .. tostring(spec.id)
            local path = spec.dir / filename
            return path:with_suffix(".md")
          end
        '';
        frontmatter.func.__raw = ''
          function(note)
            -- Preserve original titlecase title in frontmatter
            if note.title then
              note:add_alias(note.title)
            end

            local out = {
              id = note.id,
              aliases = note.aliases,
              tags = note.tags,
              display_title = note.title  -- Store original titlecase
            }

            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
              for k, v in pairs(note.metadata) do
                out[k] = v
              end
            end

            return out
          end
        '';
      };
    };
    render-markdown.enable = true;
  };
}

{
  plugins = {
    telescope = {
      enable = true;
      settings = {
        defaults = {
          file_ignore_patterns = [
            "^.git/"
            "*.ico"
            "*.lock"
            "flake.lock"
            "pnpm-lock.yaml"
            "package-lock.json"
            "*.jpg"
            "*.jpeg"
            "*.png"
            "node_modules"
            ".venv"
            "result/*"
            "^__pycache__/"
            "^.mypy_cache/"
            "^target/"
            "^dist/"
            "^build/"
            "*.pyc"
            "*.pyo"
            "*.pyd"
            ".DS_Store"
            "Thumbs.db"
            "*.log"
            "*.tmp"
            "*.temp"
            "^output/"
            "^data/"
            "%.ipynb"
            "^coverage/"
            "^.coverage"
            "^htmlcov/"
            "*.egg-info/"
            ".pytest_cache/"
            ".tox/"
            "^vendor/"
            "^third_party/"
            "*.min.js"
            "*.min.css"
            "^\\.sass-cache/"
            "^.next/"
            "^.nuxt/"
            "^.vscode/"
            "^.idea/"
            "*.swp"
            "*.swo"
          ];
          layout_config = {
            prompt_position = "top";
          };
          sorting_strategy = "ascending";
        };
        pickers = {
          git_files = {
            show_untracked = true;
            recurse_submodules = false;
          };
        };
      };

      extensions = {
        project = {
          enable = true;
          settings = {
            base_dirs = [
              "~/repos"
              "~/nixconfig"
              "~/Documents"
            ];
          };
        };
        frecency.enable = true;
        fzf-native.enable = true;
        zoxide.enable = true;
        live-grep-args.enable = true;
        file-browser = {
          enable = true;
          settings = {
            mappings = {
              n = {
                "c" = "require('telescope._extensions.file_browser.actions').create";
              };
              i = {
                "<A-c>" = "require('telescope._extensions.file_browser.actions').create";
                "<S-CR>" = "require('telescope._extensions.file_browser.actions').create_from_prompt";
              };
            };
          };
        };
      };
      keymaps = {
        "<leader><Tab>" = "buffers";
        "<leader>fd" = "find_files";
        "<leader>ff" = "live_grep_args";
        "<leader>fb" = "buffers";
        "<leader>fh" = "help_tags";
        "<leader>fp" = "project";
        "<leader>fr" = "frecency";
        "<leader>cd" = "zoxide list";
        "<leader>fa" = "file_browser";
      };
    };
    refactoring.enableTelescope = true;
  };
  keymaps = [
    {
      key = "<S-f>";
      mode = [
        "n"
        "v"
      ];
      action.__raw = ''
        function()
          local text = getVisualSelection()
          require('telescope').extensions.live_grep_args.live_grep_args({
            default_text = text,
          })
        end
      '';
      options.desc = "find in files";
    }
  ];
  extraConfigLua = ''
    function getVisualSelection()
      vim.cmd('noau normal! "vy"')
      local text = vim.fn.getreg('v')
      vim.fn.setreg("v", {})

      text = string.gsub(text, "\n", "")
      if #text > 0 then
        return text
      else
        return ""
      end
    end
  '';
}

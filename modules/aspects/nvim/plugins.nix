{ den, lib, ... }:
{
  den.aspects.nvim = {
    provides.plugins = {
      includes = [
        den.aspects.nvim._.bufferline
        den.aspects.nvim._.cmp
        den.aspects.nvim._.gitsigns
        den.aspects.nvim._.lualine
        den.aspects.nvim._.noice
        den.aspects.nvim._.nvim-tree
        den.aspects.nvim._.telescope
        den.aspects.nvim._.treesitter
        den.aspects.nvim._.obsidian
      ];
      homeManager =
        {
          programs.nixvim = {
            plugins = {
              fzf-lua = {
                enable = true;
              };
              bufdelete.enable = true;
              dashboard.enable = true;
              illuminate.enable = true;
              lint.enable = true;
              mini-pairs.enable = true;
              nix-develop.enable = true;
              notify.enable = true;
              render-markdown.enable = lib.mkDefault true;
              smart-splits.enable = true;
              tmux-navigator.enable = true;
              kitty-navigator.enable = true;
              trouble.enable = true;
              trim.enable = true;
              twilight.enable = true;
              web-devicons.enable = true;
              tiny-inline-diagnostic = {
                enable = true;
                settings = {
                  virt_texts = {
                    priority = 2048;
                  };
                };
              };

              refactoring = {
                enable = true;
                enableTelescope = lib.mkDefault false;
              };
              which-key = {
                enable = true;
                settings = {
                  preset = "modern";
                  layout = {
                    spacing = 5;
                    width = {
                      min = 40;
                      max = 80;
                    };
                  };
                };
              };
            };
          };
        };
    };
  };
}

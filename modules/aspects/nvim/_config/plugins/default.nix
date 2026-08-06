{ lib, ... }:
{
  imports = [
    ./bufferline.nix
    ./cmp.nix
    ./gitsigns.nix
    ./lualine.nix
    ./noice.nix
    ./nvim-tree.nix
    ./telescope.nix
    ./treesitter.nix
    ./obsidian-md.nix
  ];
  plugins = {
    fzf-lua = {
      enable = true;
    };
    bufdelete.enable = true;
    dashboard.enable = true;
    illuminate.enable = true;
    lint.enable = true;
    mini-pairs.enable = true;
    mini-surround.enable = true;
    nix-develop.enable = true;
    notify.enable = true;
    # nvim-ufo.enable = true;
    render-markdown.enable = lib.mkDefault true;
    smart-splits.enable = true;
    # hmts.enable = true;
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
}

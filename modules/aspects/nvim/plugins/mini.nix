{ lib, ... }:
{
  den.aspects.nvim.mini = {
    homeManager = {
      programs.nixvim.plugins = {
        mini-ai.enable = true;
        mini-basics.enable = true;
        mini.mockDevIcons = true;
        mini-pairs.enable = true;
        mini-surround.enable = true;
        mini-hipatterns.enable = lib.mkDefault true;
      };
    };
  };
}

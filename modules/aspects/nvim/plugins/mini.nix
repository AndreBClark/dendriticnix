{
  den.aspects.nvim._.mini = {
    homeManager =
      {
        programs.nixvim = {
          plugins = {
            mini.mockDevIcons = true;
            mini-pairs.enable = true;
          };
        };
      };
  };
}

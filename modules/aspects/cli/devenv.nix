{
  den.aspects.cli.devenv = {
    homeManager = {
      programs = {
        direnv = {
          enable = true;
          silent = true;
          nix-direnv.enable = true;
        };
        devenv.enable = true;
      };
    };
  };
}

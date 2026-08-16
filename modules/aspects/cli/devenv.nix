{
  den.aspects.cli.provides.devenv = {
    homeManager = {
      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        devenv.enable = true;
      };
    };
  };
}

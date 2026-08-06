{
  den.aspects.cli.provides.nh = {
    homeManager =
      { config, ... }:
      {
        programs.nh = {
          enable = true;
          clean = {
            enable = true;
            extraArgs = "--keep-since 4d --keep 3";
            dates = "monthly";
          };
          flake = "/home/${config.home.username}/nixconfig/";
        };
      };
  };
}

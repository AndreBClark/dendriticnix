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
          flake = "${config.home.homeDirectory}/nixconfig";
        };
        home.shellAliases = {
          nhs = "nh search";
          nho = "nh os switch";
          nhh = "nh home switch";
        };
      };
  };
}

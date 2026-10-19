{
  den.aspects.cli.nh = {
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
          flake = "${config.home.homeDirectory}/repos/nixconfig";
        };
        home.shellAliases = {
          nhs = "nh search";
          nho = "nh os switch";
          nht = "nh os test";
          nhh = "nh home switch";
        };
      };
  };
}

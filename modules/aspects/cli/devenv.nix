{ den, ... }:
{
  den.aspects.cli.devenv = {
    includes = [
      (den.batteries.shell-integrations [
        "devenv"
      ])
    ];

    homeManager = {
      programs = {
        devenv.enable = true;
      };
    };
  };
}

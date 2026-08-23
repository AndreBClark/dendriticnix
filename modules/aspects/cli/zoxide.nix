{
  den.aspects.cli.zoxide = {
    homeManager = {
      home.sessionVariables = {
        _ZO_EXCLUDE_DIRS = "/nix";
      };
      programs.zoxide.enable = true;
      home.shellAliases = {
        cd = "z";
      };

    };
  };
}

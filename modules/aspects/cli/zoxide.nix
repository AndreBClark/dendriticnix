{
  den.aspects.cli.provides.zoxide = {
    homeManager = {
      home.sessionVariables = {
        _ZO_EXCLUDE_DIRS = "/nix";
      };
      programs.zoxide.enable = true;
    };
  };
}

{ den, ... }:
{
  den.aspects.development = {
    includes =
      builtins.attrValues {
        inherit (den.aspects)
          terminal
          shell
          cli
          nvim
          ;
      }
      ++ [ den.aspects.folders.development ];
  };
  den.aspects.folders.development = {
    homeManager =
      { config, ... }:
      {
        xdg.userDirs.extraConfig.REPOS = "${config.home.homeDirectory}/repos";
      };
  };
}

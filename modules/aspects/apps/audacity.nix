{
  den.aspects.apps.audacity = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.audacity ];
      };
  };
}

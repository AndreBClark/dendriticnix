{
  den.aspects.apps.audacity = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.audacity_3 ];
      };
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.audacity_3 ];
      };
  };
}

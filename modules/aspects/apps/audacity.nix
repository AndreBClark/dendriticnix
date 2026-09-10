{
  den.aspects.apps.audacity = {
    homeManager =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.audacity ];
      };
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.audacity ];
      };
  };
}

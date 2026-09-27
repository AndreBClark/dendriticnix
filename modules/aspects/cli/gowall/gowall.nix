{ den, ... }:
{
  den.aspects.cli.gowall = {
    packages = { pkgs, ... }: {
      tinted-gowall = pkgs.callPackage ./_package.nix { };
    };
    homeManager = { pkgs, ... }: {
      home.packages = [ (pkgs.callPackage ./_package.nix { }) ];
    };
  };
  den.schema.flake-system.includes = [
    den.aspects.cli.gowall
  ];
}

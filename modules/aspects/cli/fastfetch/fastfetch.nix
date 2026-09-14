{
  den.aspects.cli.fastfetch = {
    nixos = { pkgs, ... }: { environment.systemPackages = [ pkgs.fastfetch ]; };
    homeManager = {
      programs.fastfetch = {
        enable = true;
        settings = builtins.fromJSON (builtins.readFile ./6.jsonc);
      };
    };
  };
}

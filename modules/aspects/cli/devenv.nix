{ den, ... }:
{
  den.aspects.cli.devenv =
    let
      direnv = {
        enable = true;
        silent = true;
        nix-direnv.enable = true;
      };
    in
    {
      includes = [
        (den.batteries.shell-integrations [
          "devenv"
          "direnv"
        ])
      ];

      nixos = {
        programs = {
          inherit direnv;
        };
      };
      homeManager = {
        programs = {
          inherit direnv;
          devenv = {
            enable = true;
          };
        };
      };
    };
}

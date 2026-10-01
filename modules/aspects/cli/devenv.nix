{ den, lib, ... }:
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
            enableFishIntegration = lib.mkForce false;
          };
        };
      };
    };
}

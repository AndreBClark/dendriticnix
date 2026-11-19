{
  den,
  lib,
  inputs,
  ...
}:
{
  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
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

      nixos =
        { config, ... }:
        {
          imports = [ inputs.sops-nix.nixosModules.sops ];
          programs = {
            inherit direnv;
          };

          sops = {
            defaultSopsFile = ../../../secrets.yaml;
            age.keyFile = "/home/andrec/.config/sops/age/keys.txt";

            secrets."nix-netrc" = {
              mode = "0440";
              group = "wheel";
            };
            secrets."gitlab-pat" = { };
          };

          nix.extraOptions = ''
            netrc-file = ${config.sops.secrets."nix-netrc".path}
          '';
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

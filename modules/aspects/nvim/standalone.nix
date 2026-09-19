{
  den,
  lib,
  inputs,
  ...
}:
{
  den = {
    classes = {
      nixvim = {
        description = "Portable nixvim configuration (standalone or home-manager)";
      };
    };
    default = {
      includes = [
        den.policies.nixvim-hm-module
      ];
    };

    lib = {
      nixvim = {
        module = nvimAspect: den.lib.aspects.resolve "nixvim" nvimAspect;

        package =
          pkgs: nvimAspect: extraModules:
          (inputs.nixvim.lib.evalNixvim {
            system = pkgs.stdenv.hostPlatform.system;
            modules = [
              (den.lib.nixvim.module nvimAspect)
              { nixpkgs = { inherit pkgs; }; }
            ]
            ++ extraModules;
          }).config.build.package.overrideAttrs
            (old: {
              pname = "nixvim";
              version = old.version or "0.0.0";
            });

        mkColorscheme =
          {
            user,
            pkgs,
            lib,
          }:
          let
            colorscheme = den.lib.theme.palette { inherit pkgs lib user; };
          in
          {
            colorschemes.base16 = {
              enable = true;
              inherit colorscheme;
            };
          };
      };
    };

    policies = {
      nixvim-hm-module =
        # deadnix: skip
        { host, user, ... }:
        [
          (den.lib.policy.provide {
            class = "homeManager";
            module = {
              key = "den:nixvim-hm-module";
              imports = [ inputs.nixvim.homeModules.nixvim ];
              programs.nixvim.enable = lib.mkDefault true;
            };
          })

        ];
    };
  };
}

{ den, ... }:
{
  den.aspects.cli.update = {
    packages = { pkgs, ... }: {
      update = pkgs.writeShellApplication {
        name = "update";
        runtimeInputs = [ pkgs.npins ];
        text = ''
          npins update
          nix flake update
        '';
      };
    };
  };
  den.schema.flake-system.includes = [ den.aspects.cli.update ];
}

{ den, ... }:
{
  den.aspects.cli.update = {
    packages = { pkgs, ... }: {
      update = pkgs.writeShellApplication {
        name = "update";
        runtimeInputs = [
          pkgs.npins
          pkgs.git
        ];
        text = ''
          npins update
          nix flake update
          git reset HEAD -- *
          git add npins/*
          git add flake.lock
          git commit -m "chore: update npins and flake lock"
        '';
      };
    };
  };
  den.schema.flake-system.includes = [ den.aspects.cli.update ];
}

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
          git reset HEAD -- *
          nix run .#write-flake
          nix run .#write-inputs
          npins update
          nix flake update
          git add npins/* flake.lock flake.nix inputs.nix
          git commit -m "chore: write inputs, update npins and flake lock"
        '';
      };
    };
  };
  den.schema.flake-system.includes = [ den.aspects.cli.update ];
}

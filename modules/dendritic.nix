{ inputs, den, ... }:
{
  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
    (inputs.treefmt-nix.flakeModule or { })
  ];
  den.schema.user.includes = [ den.provides.define-user ];
  den.schema.flake-system.includes = [ den.aspects.my-packages ];
  _module.args.__findFile = den.lib.__findFile;

  # other inputs may be defined at a module using them.
  flake-file.inputs = {
    den.url = "github:vic/den";
    flake-file.url = "github:vic/flake-file";
    treefmt-nix.url = "github:numtide/treefmt-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

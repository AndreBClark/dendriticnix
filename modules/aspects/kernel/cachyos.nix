{

  flake-file.inputs = {
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };
  den.aspects.kernel.cachyos = {
    nixos =
      { pkgs, inputs, ... }:
      {
        nixpkgs.overlays = [
          inputs.nix-cachyos-kernel.overlays.pinned
        ];
        boot.kernelPackages = pkgs.cachyosKernels.linux-cachyos-lts-x86_64-v3;
      };
  };
}

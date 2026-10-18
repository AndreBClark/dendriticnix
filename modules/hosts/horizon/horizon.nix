{ den, ... }:
{
  flake-file.inputs = {
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  den = {
    hosts.x86_64-linux.horizon = {

      kernel = "";
      hardware = {
        cpu = "intel";
        gpu = "nvidia-nonprime-pascal";
        storage = [ "hdd" ];
      };
      users.andrec = { };
      nixos =
        { pkgs, inputs, ... }:
        {
          nixpkgs.overlays = [
            inputs.nix-cachyos-kernel.overlays.pinned
          ];
          boot.kernelPackages = pkgs.cachyosKernels.linux-cachyos-lts-x86_64-v3;
        };
    };

    aspects.seadragon = {
      includes = builtins.attrValues {
        inherit (den.aspects)
          base-host
          gaming
          ;
      };
    };
  };
}

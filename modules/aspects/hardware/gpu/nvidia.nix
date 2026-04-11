{ inputs, ... }:
{
  den.aspects.hardware.nvidia = {
    nixos =
      { config, pkgs, ... }:
      {
        # GPU variant: nonprime
        provides.nonprime = {
          nixos = {
            imports = builtins.attrValues {
              inherit (inputs.hardware.nixosModules)
                common-gpu-nvidia-nonprime
                ;
            };
          };
        };

        # GPU variant: prime (for laptops with integrated + discrete)
        provides.prime = {
          nixos = {
            imports = builtins.attrValues {
              inherit (inputs.hardware.nixosModules)
                common-gpu-nvidia-prime
                ;
            };
          };
        };

        # Security and services
        security.rtkit.enable = true;
        services = {
          xserver = {
            enable = true;
            videoDrivers = [ "nvidia" ];
          };
          printing.enable = true;
          gvfs.enable = true;
          udisks2.enable = true;
        };

        # Kernel parameters for NVIDIA
        boot.kernelParams = [
          "nvidia-drm.modeset=1"
          "nvidia-drm.fbdev=1"
          "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
          "nvidia.NVreg_TemporaryFilePath=/var/tmp"
          "nvidia.NVreg_EnableGpuFirmware=0"
        ];

        # Hardware configuration
        hardware = {
          graphics = {
            enable = true;
            enable32Bit = true;
          };
          nvidia = {
            open = false;
            package = config.boot.kernelPackages.nvidiaPackages.production;
            modesetting.enable = true;
          };
        };
      };
  };
}

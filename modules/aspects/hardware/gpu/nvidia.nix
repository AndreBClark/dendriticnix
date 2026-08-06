{ den, inputs, ... }:
{
  den.aspects.hardware = {
    gpu = {
      provides = {
        nvidia-nonprime = {
          nixos = {
            includes = [ den.aspects.hardware.gpu.nvidia ];
            imports = builtins.attrValues {
              inherit (inputs.hardware.nixosModules)
                common-gpu-nvidia-nonprime
                ;
            };
          };
        };

        # GPU variant: prime (for laptops with integrated + discrete)
        nvidia-prime = {
          nixos = {
            includes = [ den.aspects.hardware.gpu.nvidia ];
            imports = builtins.attrValues {
              inherit (inputs.hardware.nixosModules)
                common-gpu-nvidia
                ;
            };
          };
        };

        nvidia-nonprime-pascal = {
          includes = [ den.aspects.hardware.gpu.nvidia ];
          nixos.imports = [
            inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
            "${inputs.hardware}/common/gpu/nvidia/pascal"
          ];
        };
      };
      nvidia = {
        nixos =
          {
            services.xserver.enable = true;

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
                modesetting.enable = true;
              };
            };
          };
      };
    };
  };
}

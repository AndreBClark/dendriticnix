{
  den.schema.host =
    { lib, host, ... }:
    {
      options = {
        kernel = lib.mkOption {
          type = lib.types.enum [
            "xanmod"
            "cachyos"
            "latest"
          ];
          default = "xanmod";
        };
        windowManager = lib.mkOption {
          type = lib.types.str;
          default = "niri";
        };
        desktopShell = lib.mkOption {
          type = lib.types.str;
          default = "dms";
        };
        theme = lib.mkOption {
          type = lib.types.submodule (import ./theme.nix);
          default = { };
        };
        hardware = {
          cpu = lib.mkOption {
            type = lib.types.enum [ "intel" ];
            default = "intel";
          };
          storage = lib.mkOption {
            type = lib.types.listOf (lib.types.enum [ "ssd" ]);
            default = [ "ssd" ];
          };
          gpu = lib.mkOption {
            type = lib.types.nullOr (
              lib.types.enum [
                "nvidia-nonprime"
                "nvidia-prime"
                "nvidia-nonprime-pascal"
              ]
            );
            default = null;
          };
          formFactor = lib.mkOption {
            type = lib.types.nullOr (
              lib.types.enum [
                "desktop"
                "laptop"
              ]
            );
            default = "desktop";
          };
          model = lib.mkOption {
            type = lib.types.str;
            default = "generic";
          };

          gpuMode = lib.mkOption {
            type = lib.types.nullOr (
              lib.types.enum [
                "hybrid"
                "nvidia"
                "intel"
              ]
            );
            default = if host.hardware.formFactor == "laptop" then "hybrid" else null;
          };
          grubLogoSize = lib.mkOption {
            type = lib.types.enum [
              "small"
              "medium"
              "large"
            ];
            default = "medium";
          };
        };
      };
      config.assertions = [
        {
          assertion = host.hardware.gpuMode == null || host.hardware.formFactor == "laptop";
          message = "hardware.gpuMode is only meaningful for formFactor = \"laptop\" hosts";
        }
        {
          assertion = host.hardware.gpu == null || host.hardware.gpuMode != null;
          message = "hardware.gpu is set but hardware.gpuMode is null — a GPU mode (hybrid/nvidia/intel) must be chosen when a discrete GPU is present";
        }
        {
          assertion = host.hardware.gpuMode != "nvidia" || host.hardware.gpu != null;
          message = "hardware.gpuMode = \"nvidia\" requires hardware.gpu to be set to one of the nvidia variants";
        }
        {
          assertion = host.hardware.formFactor == "laptop" || host.hardware.gpuMode == null;
          message = "hardware.gpuMode should only be set for laptop formFactor; desktops don't switch GPU modes";
        }
      ];
    };
}

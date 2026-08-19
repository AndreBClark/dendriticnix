{
  den.schema.host =
    { lib, host, ... }:
    {
      options = {
        windowManager = lib.mkOption {
          type = lib.types.str;
          default = "niri";
        };
        desktopShell = lib.mkOption {
          type = lib.types.str;
          default = "dms";
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
            type = lib.types.nullOr (lib.types.enum [
              "nvidia-nonprime"
              "nvidia-prime"
              "nvidia-nonprime-pascal"
            ]);
            default = null;
          };
          formFactor = lib.mkOption {
            type = lib.types.nullOr (lib.types.enum [ "desktop" "laptop" ]);
            default = "desktop";
          };
          gpuMode = lib.mkOption {
            type = lib.types.nullOr (lib.types.enum [ "hybrid" "nvidia" "intel" ]);
            default = if host.hardware.formFactor == "laptop" then "hybrid" else null;
          };
        };
        config.assertions = [
          {
            assertion = host.hardware.gpuMode == null || host.formFactor == "laptop";
            message = "hardware.gpuMode is only meaningful for formFactor = \"laptop\" hosts";
          }
        ];
      };
    };
}

{ lib, ... }:
{
  options = {
    colorscheme = lib.mkOption {
      type = lib.types.str;
      default = "tokyo-night-storm";
    };

    iconTheme = lib.mkOption {
      type = lib.types.str;
      default = "Dracula";
    };

    cursor = lib.mkOption {
      type = lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            default = "BreezeX-RosePine-Linux";
          };

          package = lib.mkOption {
            type = lib.types.str;
            default = "rose-pine-cursor";
          };

          size = lib.mkOption { type = lib.types.int; default = 32; };
        };
      };

      default = {
        name = "BreezeX-RosePine-Linux";
        package = "rose-pine-cursor";
        size = 32;
      };
    };

    opacity = lib.mkOption {
      type = lib.types.submodule {
        options = {
          desktop = lib.mkOption { type = lib.types.float; default = 1.000; };
          popups = lib.mkOption { type = lib.types.float; default = 1.000; };
          applications = lib.mkOption { type = lib.types.float; default = 1.000; };
          terminal = lib.mkOption { type = lib.types.float; default = 1.000; };
        };
      };

      default = {
        desktop = 0.500;
        popups = 0.500;
        applications = 0.900;
        terminal = 0.800;
      };
    };

    polarity = lib.mkOption {
      type = lib.types.enum [ "either" "dark" "light" ];
      default = "dark";
    };
  };
}

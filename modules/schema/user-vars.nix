{ lib, config, ... }:
{
  den.schema.user = { host, ... }: {
    options = {
      user = lib.mkOption {
        type = lib.types.submodule {
          options = {
            name = lib.mkOption {
              type = lib.types.str;
            };

            email = lib.mkOption {
              type = lib.types.str;
            };
          };
        };
        default = { };
      };

      keyboard = lib.mkOption {
        type = lib.types.submodule (import ./keyboard.nix);
        default = { };
      };

      terminal = lib.mkOption {
        type = lib.types.str;
        default = "kitty";
      };

      editor = lib.mkOption {
        type = lib.types.str;
        default = "nvim";
      };

      browser = lib.mkOption {
        type = lib.types.str;
        default = "vivaldi";
      };

      shell = lib.mkOption {
        type = lib.types.str;
        default = "fish";
      };

      windowManager = lib.mkOption {
        type = lib.types.str;
        default = host.windowManager;
      };

      desktopShell = lib.mkOption {
        type = lib.types.str;
        default = host.desktopShell;
      };

      theme = lib.mkOption {
        type = lib.types.submodule (import ./theme.nix);
        default = { };
      };
    };
    config.assertions = [
      {
        assertion = lib.all (v: v >= 0.0 && v <= 1.0) (lib.attrValues config.opacity);
        message = "theme.opacity values must be between 0.0 and 1.0";
      }
      {
        assertion = lib.elem config.polarity [ "dark" "light" ];
        message = "theme.polarity must be either \"dark\" or \"light\"";
      }
    ];
  };
}

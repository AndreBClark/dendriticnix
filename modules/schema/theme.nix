{ lib, ... }:
{
  options = {
    colorscheme = lib.mkOption {
      type =
        with lib.types;
        oneOf [
          path
          lines
          attrs
        ];
      default = "tokyo-night-dark";
    };

    fonts = lib.mkOption {
      type = lib.types.submodule {
        options =
          let
            mkFont =
              name: package:
              lib.mkOption {
                type = lib.types.submodule {
                  options = {
                    name = lib.mkOption {
                      type = lib.types.str;
                      default = name;
                    };
                    package = lib.mkOption {
                      type = lib.types.str;
                      default = package;
                    };
                  };
                };
                default = { };
              };
            mkSize =
              default:
              lib.mkOption {
                type = lib.types.either lib.types.ints.unsigned lib.types.float;
                inherit default;
              };
          in
          {
            monospace = mkFont "JetBrainsMono Nerd Font" "nerd-fonts.jetbrains-mono";
            sansSerif = mkFont "JetBrainsMono Nerd Font" "nerd-fonts.jetbrains-mono";
            serif = mkFont "JetBrainsMono Nerd Font" "nerd-fonts.jetbrains-mono";
            emoji = mkFont "Noto Emoji" "noto-fonts-monochrome-emoji";
            sizes = {
              desktop = mkSize 10;
              applications = mkSize 12;
              terminal = mkSize 14;
              popups = mkSize 10;
            };
          };
      };
      default = { };
    };
    icons = lib.mkOption {
      type = lib.types.submodule {
        options =
          let
            defaultName = "Papirus-Dark";
          in
          {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = true;
            };
            dark = lib.mkOption {
              type = lib.types.str;
              default = defaultName;
            };

            light = lib.mkOption {
              type = lib.types.str;
              default = "Papirus-Light";
            };
            package = lib.mkOption {
              type = lib.types.str;
              default = "papirus-icon-theme";
            };
          };
      };
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

          size = lib.mkOption {
            type = lib.types.int;
            default = 32;
          };
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
          desktop = lib.mkOption {
            type = lib.types.float;
            default = 1.000;
          };
          popups = lib.mkOption {
            type = lib.types.float;
            default = 1.000;
          };
          applications = lib.mkOption {
            type = lib.types.float;
            default = 1.000;
          };
          terminal = lib.mkOption {
            type = lib.types.float;
            default = 1.000;
          };
        };
      };

      default = {
        desktop = 0.750;
        popups = 0.750;
        applications = 0.900;
        terminal = 0.80;
      };
    };

    polarity = lib.mkOption {
      type = lib.types.enum [
        "either"
        "dark"
        "light"
      ];
      default = "dark";
    };
  };
}

{ lib, ... }:
{
  options = {
    colorscheme = lib.mkOption {
      type = lib.types.str;
      default = "tokyo-night";
    };
    variant = lib.mkOption {
      type = lib.types.str;
      default = "storm";
    };
    iconTheme = lib.mkOption {
      type = lib.types.str;
      default = "Dracula";
    };
    cursorName = lib.mkOption {
      type = lib.types.str;
      default = "BreezeX-RosePine-Linux";
    };
    opacity = lib.mkOption {
      type = lib.types.attrs;
      default = {
        desktop = 0.500;
        popups = 0.500;
        applications = 0.900;
        terminal = 0.800;
      };
    };
    polarity = lib.mkOption {
      type = lib.types.str;
      default = "dark";
    };
  };
}

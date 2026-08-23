{ lib, ... }:
{
  options = {
    layout = lib.mkOption {
      type = lib.types.commas;
      default = "us";
      description = ''
        X keyboard layout, or multiple keyboard layouts separated by commas.
      '';
    };

    model = lib.mkOption {
      type = lib.types.str;
      default = "pc104";
      description = ''
        X keyboard model.
      '';
    };

    options = lib.mkOption {
      default = "altwin:menu_win,ctrl:nocaps";
      type = lib.types.commas;
      example = "grp:caps_toggle,grp_led:scroll";
      description = ''
        X keyboard options; layout switching goes here.
      '';
    };

    variant = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = "dvorak";
      description = ''
        X keyboard variant.
      '';
    };
  };
}

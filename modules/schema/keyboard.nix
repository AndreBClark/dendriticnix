{ lib, ... }:
{
  options = {
    layout = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = "us";
    };
    model = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = "pc104";
    };
    options = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "altwin:menu_win" "ctrl:nocaps" ];
    };
    variant = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };
  };
}

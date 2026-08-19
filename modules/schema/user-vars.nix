{ lib, ... }:
{
  den.schema.user = { host, ... }: {
    options = {
      keyboard = lib.mkOption {
        type = lib.types.attrs;
        default = {
          layout = "us";
          options = lib.strings.concatStringsSep "," [
            "altwin:menu_win"
            "ctrl:nocaps"
          ];
          model = "pc104";
        };
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
  };
}

{ lib, ... }:

{
  den.schema.profile =
    { host, ... }:
    {
      options = {
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
          default = host.windowManager or "niri";
        };

        desktopShell = lib.mkOption {
          type = lib.types.str;
          default = host.desktopShell or "dms";
        };

        theme = lib.mkOption {
          type = lib.types.submodule (import ./theme.nix);
          default = host.theme or { };
        };
      };
    };
}

{ lib, ... }:
{
  den.aspects.dms.greeter = {
    nixos =
      {
        user,
        host,
        pkgs,
        ...
      }:
      {
        services.displayManager = {
          sddm.enable = false;
          dms-greeter = {
            enable = true;
            compositor = {
              name = host.windowManager;
              customConfig = ''
                hotkey-overlay {
                  skip-at-startup
                }
                cursor {
                  xcursor-theme "${user.theme.cursor.name}"
                  xcursor-size ${toString user.theme.cursor.size}
                }
                debug {
                  disable-cursor-plane
                  keep-max-bpc-unchanged
                }
              '';
            };
            configHome = "/home/${user.userName}";
            configFiles = [
              "/home/${user.userName}/.face"
            ];
          };
          autoLogin = {
            enable = lib.mkDefault false;
            user = user.userName;
          };

        };
        environment.systemPackages = [
          pkgs.${user.theme.cursor.package}
        ];
      };
  };
}

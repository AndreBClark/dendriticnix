{
  den.aspects.dms.greeter = {
    nixos =
      {
        config,
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
            configHome = "/home/${config.users.users.${builtins.head (builtins.attrNames host.users)}.name}";

          };
          autoLogin = {
            enable = false;
            user = user.userName;
          };

        };
        environment.systemPackages = [
          pkgs.${user.theme.cursor.package}
        ];
      };
  };
}

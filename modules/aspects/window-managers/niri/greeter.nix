{
  den.aspects.wm.niri = {
    nixos =
      { config, host, pkgs, ... }:
      {
        services.displayManager = {
          sddm.enable = false;
          dms-greeter = {
            enable = true;
            compositor = {
              name = "niri";
              customConfig = ''
                hotkey-overlay {
                  skip-at-startup
                }
                cursor {
                  xcursor-theme "BreezeX-RosePine-Linux"
                  xcursor-size 48
                }
                debug {
                  disable-cursor-plane
                  keep-max-bpc-unchanged
                }
              '';
            };
            # Support multiple users - use a generic approach
            configHome = "/home/${config.users.users.${builtins.head (builtins.attrNames host.users)}.name}";

          };
        };
        environment.systemPackages = [ pkgs.rose-pine-cursor ];
      };
  };
}

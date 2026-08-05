{ den, ... }: {
  den.aspects.wm.niri = {
    includes = [ den.aspects.dms ];
    nixos =
      { config, pkgs, host, ... }:
      {
        environment = {
          variables.NIXOS_OZONE_WL = "1";
          systemPackages = builtins.attrValues {
            inherit (pkgs)
              wayland-utils
              libsecret
              xwayland-satellite
              xdg-desktop-portal-gnome
              ;
          };
        };
        programs.niri.enable = true;
        services.displayManager = {
          sddm.enable = false;
          dms-greeter = {
            enable = true;
            compositor.name = "niri";
            # Support multiple users - use a generic approach
            configHome = "/home/${config.users.users.${builtins.head (builtins.attrNames host.users)}.name}";
          };
        };
      };
    homeManager =
      { pkgs, ... }:
      {
        wayland.windowManager.niri = {
          enable = true;
        };
        home.packages = [
          pkgs.rose-pine-cursor
        ];
      };
  };
}

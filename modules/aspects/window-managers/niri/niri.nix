{ den, ... }:
{
  den.aspects.wm.niri = {
    includes = [ den.aspects.dms ];
    nixos =
      { pkgs, ... }:
      {
        programs.niri.enable = true;
        environment = {
          variables.NIXOS_OZONE_WL = "1";
          systemPackages = builtins.attrValues {
            inherit (pkgs)
              wayland-utils
              libsecret
              xwayland-satellite
              xdg-desktop-portal-gnome
              rose-pine-cursor
              ;
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

{ __findFile, ... }:
{
  den.aspects.niri =
    { user, ... }:
    {
      includes = [
        (if user.desktopShell == "dms" then [
          <dms>
          <dms/niri-includes>
        ] else { })
        <niri/binds>
        <niri/config>
        <niri/outputs>
        <niri/window-rules>
      ];
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
          wayland.windowManager.niri.enable = true;
          home.packages = [
            pkgs.rose-pine-cursor
          ];
        };
    };
}

{
  den.aspects.wm.niri =
    { host, ... }:
    {
      nixos =
        { config, pkgs, ... }:
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
      homeManager = {
        imports = [
          ../config/niri
        ];
      };
    };
}

{
  den.aspects.portal = {
    nixos =
      { pkgs, ... }:

      let
        portals = builtins.attrValues {
          inherit (pkgs)
            xdg-desktop-portal-gtk
            xdg-desktop-portal-gnome
            ;
        };
      in
      {
        xdg.portal = {
          enable = true;
          xdgOpenUsePortal = true;
          wlr.enable = true;
          extraPortals = portals;
          configPackages = portals;
        };
      };
  };
}

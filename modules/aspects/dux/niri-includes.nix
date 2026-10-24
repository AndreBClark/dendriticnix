{ lib, ... }:
{
  den.aspects.dux.niri-includes = {
    homeManager =
      let
        sources = import ../../../npins;
        duxShell = "${sources.dux-shell}/core/internal/config/embedded/niri";
      in
      {
        xdg.configFile = {
          "niri/dms.kdl".text = lib.concatStringsSep "\n" (
            lib.lists.dropEnd 9 (lib.splitString "\n" (builtins.readFile "${duxShell}.kdl"))
          );
          "niri/dms/alttab.kdl".source = "${duxShell}-alttab.kdl";
          "niri/dms/binds.kdl".source = "${duxShell}-binds.kdl";
          "niri/dms/input.kdl".source = "${duxShell}-input.kdl";
          "niri/dms/layout.kdl".source = "${duxShell}-layout.kdl";
        };
        wayland.windowManager.niri.extraConfig = lib.mkBefore ''
          include optional=true "dms.kdl"
          include optional=true "dms/alttab.kdl"
          include optional=true "dms/binds.kdl"
          include optional=true "dms/input.kdl"
          include optional=true "dms/layout.kdl"
        '';
      };
  };
}

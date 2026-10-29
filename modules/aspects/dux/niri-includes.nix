{ lib, ... }:
{
  den.aspects.dux.niri-includes = {
    homeManager =
      let
        sources = import ../../../npins;
        duxShell = "${sources.dux-shell}/core/internal/config/embedded/niri";
      in
      {
        xdg.configFile =
          let
            duxDir = "niri/dux";
          in
          {
            "${duxDir}.kdl".text = lib.concatStringsSep "\n" (
              lib.lists.dropEnd 9 (lib.splitString "\n" (builtins.readFile "${duxShell}.kdl"))
            );
            "${duxDir}/alttab.kdl".source = "${duxShell}-alttab.kdl";
            "${duxDir}/binds.kdl".source = "${duxShell}-binds.kdl";
            "${duxDir}/input.kdl".source = "${duxShell}-input.kdl";
            "${duxDir}/layout.kdl".source = "${duxShell}-layout.kdl";
          };
        wayland.windowManager.niri.extraConfig = lib.mkBefore ''
          include optional=true "dux.kdl"
          include optional=true "dux/alttab.kdl"
          include optional=true "dux/binds.kdl"
          include optional=true "dux/input.kdl"
          include optional=true "dux/layout.kdl"
        '';
      };
  };
}

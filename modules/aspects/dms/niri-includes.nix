{
  den.aspects.dms.niri-includes = {
    homeManager =
      let
        sources = import ../../../npins;
        dmsSrc = "${sources.DankMaterialShell}/core/internal/config/embedded/niri";
      in
      {
        xdg.configFile = {
          "niri/dms.kdl".source = "${dmsSrc}.kdl";
          "niri/dms/alttab.kdl".source = "${dmsSrc}-alttab.kdl";
          "niri/dms/binds.kdl".source = "${dmsSrc}-binds.kdl";
          "niri/dms/input.kdl".source = "${dmsSrc}-input.kdl";
          "niri/dms/layout.kdl".source = "${dmsSrc}-layout.kdl";
        };
        wayland.windowManager.niri.extraConfigEarly = ''
          include optional=true "dms/niri.kdl"
          include optional=true "dms/alttab.kdl"
          include optional=true "dms/binds.kdl"
          include optional=true "dms/input.kdl"
          include optional=true "dms/layout.kdl"
        '';
      };
  };
}

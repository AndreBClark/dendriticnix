{
  den.aspects.wm.niri.homeManager =
    let
      sources = import ../../../../npins;
      dmsSrc = "${sources.DankMaterialShell}/core/internal/config/embedded/niri";
    in
    {
      xdg.configFile = {
        "niri/dms/alttab.kdl".source = "${dmsSrc}-alttab.kdl";
        "niri/dms/binds.kdl".source = "${dmsSrc}-binds.kdl";
        "niri/dms/colors.kdl".source = "${dmsSrc}-colors.kdl";
        "niri/dms/input.kdl".source = "${dmsSrc}-input.kdl";
        "niri/dms/layout.kdl".source = "${dmsSrc}-layout.kdl";
      };
      wayland.windowManager.niri.extraConfigEarly = ''
        include "${dmsSrc}.kdl"
        include optional=true "${dmsSrc}-alttab.kdl"
        include optional=true "${dmsSrc}-binds.kdl"
        include optional=true "${dmsSrc}-colors.kdl"
        include optional=true "${dmsSrc}-input.kdl"
        include optional=true "${dmsSrc}-layout.kdl"
      '';
    };
}

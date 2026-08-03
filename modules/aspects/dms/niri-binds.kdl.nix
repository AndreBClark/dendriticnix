let
  sources = import ../../../npins;
in
{
  den.aspects.dms.homeManager.xdg.configFile = {
    "niri/dms/binds.kdl".source =
      "${sources.DankMaterialShell}/core/internal/config/embedded/niri-binds.kdl";
  };
}

let
  sources = import ../../../npins;
in
{
  den.aspects.dms.homeManager.xdg.configFile."niri/dms-includes.kdl" = {
    source = "${sources.DankMaterialShell}/core/internal/config/embedded/niri.kdl";
    text = ''
      include "dms/windowrules.kdl"
    '';
  };
}

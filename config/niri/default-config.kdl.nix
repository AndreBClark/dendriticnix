let
  sources = import ../../../npins;
in
{
  xdg.configFile = {
    "niri/default-config.kdl".source = "${sources.niri}/resources/default-config.kdl";
  };
}

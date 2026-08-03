{ config, ... }:
let
  stylixToDmsTheme =
    {
      colors,
      name ? "Stylix Dark",
    }:
    {
      dark = {
        inherit name;
        primary = colors.base0B;
        primaryText = colors.base00;
        primaryContainer = colors.base02;
        secondary = colors.base0D;
        surface = colors.base01;
        surfaceText = colors.base06;
        surfaceVariant = colors.base02;
        surfaceVariantText = colors.base05;
        surfaceTint = colors.base0B;
        background = colors.base00;
        backgroundText = colors.base06;
        outline = colors.base03;
        surfaceContainer = colors.base01;
        surfaceContainerHigh = colors.base02;
        surfaceContainerHighest = colors.base03;
        error = colors.base08;
        warning = colors.base09;
        info = colors.base0C;
        matugen_type = "scheme-tonal-spot";
      };
    };

  # Generate the theme file
  dmsTheme = stylixToDmsTheme {
    colors = config.lib.stylix.colors.withHashtag;
    name = "Stylix ${config.stylix.polarity}";
  };
in
{
  den.aspects.dms.homeManager.xdg.configFile."DankMaterialShell/stylix-theme.json".text =
    builtins.toJSON dmsTheme;
}

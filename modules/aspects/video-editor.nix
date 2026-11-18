{ den, ... }:
{
  den.aspects.video-editor = {
    includes = [
      (den.batteries.unfree [
        "lightworks"
        "nvidia-cg-toolkit"
      ])
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = builtins.attrValues {
          inherit (pkgs)
            lightworks
            ;
        };
        xdg.desktopEntries.lightworks = {
          name = "Lightworks";
          icon = "${pkgs.lightworks}/share/lightworks/Icons/App.png";
          exec = "${pkgs.coreutils}/bin/env -u FONTCONFIG_FILE ${pkgs.lightworks}/bin/lightworks";
          terminal = false;
          categories = [
            "AudioVideo"
            "Video"
            "AudioVideoEditing"
          ];
        };
      };
  };
}

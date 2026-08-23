{
  den.aspects.apps.nautilus = {
    nixos =
      { pkgs, ... }:
      {

        programs = {
          niri.useNautilus = true;
          nautilus-open-any-terminal = {
            enable = true;
            terminal = "kitty";

          };
        };
        services = {
          gnome.sushi.enable = true;
          udisks2.enable = true;
        };
        nixpkgs.overlays = [
          (_: prev: {
            nautilus = prev.nautilus.overrideAttrs (nprev: {
              buildInputs =
                nprev.buildInputs
                ++ (with pkgs.gst_all_1; [
                  gst-plugins-good
                  gst-plugins-bad
                ]);
            });
          })
        ];
        environment = {
          systemPackages = [
            pkgs.nautilus
            pkgs.libheif
            pkgs.libheif.out
          ];
          pathsToLink = [ "share/thumbnailers" ];
        };
      };
    homeManager = {
      services.udiskie = {
        enable = true;
      };
    };
  };
}

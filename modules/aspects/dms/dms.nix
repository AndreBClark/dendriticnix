{
  den,
  lib,
  inputs,
  ...
}:
{
  flake-file.inputs = {
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.dms = {
    includes = builtins.attrValues {
      inherit (den.aspects.dms)
        greeter
        syncCmd
        facePicker
        ;
    };

    homeManager =
      { user, pkgs, ... }:
      {
        imports = [
          inputs.dms.homeModules.dank-material-shell
          inputs.dms-plugin-registry.homeModules.default
          inputs.danksearch.homeModules.dsearch
        ];

        programs = {
          dank-material-shell = {
            enable = true;
            systemd.enable = true;
            enableSystemMonitoring = true;
            enableDynamicTheming = true;
            enableAudioWavelength = true;
            enableCalendarEvents = true;
            settings = lib.mapAttrs (_: lib.mkDefault) (
              builtins.fromJSON (builtins.readFile ./settings.json)
              // {
                cursorSettings = {
                  theme = user.theme.cursor.name;
                  cursor = user.theme.cursor.size;
                };
              }
            );
            session = builtins.fromJSON (builtins.readFile ./session.json);
            plugins = {
              airQuality.enable = true;
              audioPortSwitcher.enable = true;
              calculator.enable = true;
              dankAudioVisualizer.enable = true;
              dankBitwarden.enable = true;
              dankObsidian.enable = true;
              displayManager.enable = true;
              emojiLauncher.enable = true;
              mediaPlayer.enable = true;
              niriWindows.enable = true;
              powerUsagePlugin.enable = true;
              volumeMixer.enable = true;
              webSearch.enable = true;
              dmsThemeSync = {
                enable = true;
                settings = {
                  applyMatugenColors = true;
                  gtkThemeDark = "Stylix";
                  qtPlatformTheme = "preserve";
                  qtStyle = "auto";
                  qtSyncMode = "auto";
                  syncFlatpak = false;
                  syncKvantum = true;
                  syncTerminalFonts = true;
                };
              };
              easyEffects = {
                enable = true;
                settings = {
                  currentInputIndex = 1;
                  currentOutputIndex = -1;
                };
              };
              wallpaperCarousel = {
                enable = true;
                settings = {
                  borderWidth = 0;
                  enable = true;
                  expandMultiplier = 150;
                  expandSelected = "true";
                  itemWidth = 300;
                  overlayOpacity = 79;
                  selectedScale = 117;
                };
              };
              wallpaperDiscovery = {
                enable = true;
                settings = {
                  api_wallhavencc = "evxZa5kqPQ0wHFD6St5hfeox0qNAbiUR";
                  downloadLocation = "/home/andrec/Pictures/Wallpapers";
                };
              };
            };
          };

          dsearch.enable = true;
        };

        home.packages = [ pkgs.dgop ];

        xdg.configFile =
          let
            colorsImport = ''@import url("dank-colors.css");'';
          in
          {
            "gtk-4.0/gtk.css".text = colorsImport;
            "gtk-3.0/gtk.css".text = colorsImport;
            "gtk-3.0/assets".source = "${pkgs.adw-gtk3}/share/themes/adw-gtk3/gtk-3.0/assets";
          };

      };
  };
}

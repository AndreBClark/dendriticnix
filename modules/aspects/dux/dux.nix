{
  den,
  lib,
  inputs,
  ...
}:
{
  flake-file.inputs = {
    dux = {
      url = "github:duxlabs-dev/dux-shell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:duxlabs-dev/dux-gop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dfiles = {
      url = "github:duxlabs-dev/dux-files";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dux-plugin-registry = {
      url = "github:duxlabs-dev/dux-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.dux = {
    includes = builtins.attrValues {
      inherit (den.aspects.dux)
        greeter
        syncCmd
        facePicker
        ;
    };

    homeManager =
      {
        user,
        pkgs,
        config,
        ...
      }:
      {
        imports = [
          inputs.dux-plugin-registry.homeModules.default
          inputs.dfiles.homeModules.dux-files
          inputs.dux.homeModules.default
        ];

        programs = {
          dank-material-shell = {
            enable = true;
            systemd.enable = true;
            enableSystemMonitoring = true;
            enableDynamicTheming = true;
            enableAudioWavelength = true;
            enableCalendarEvents = false;
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
                  downloadLocation = "${config.home.homeDirectory}/Pictures/Wallpapers-source";
                };
              };
            };
          };

          dux-files = {
            enable = true;

            # Keep a resident instance so windows open fast and the portal answers at once
            systemd = {
              enable = true;
              target = "graphical-session.target";
              restartIfChanged = true;
            };
            # Serve other apps' open and save dialogs
            portal = {
              enable = true; # register the dfiles backend with xdg-desktop-portal
              preferred = true; # prefer it for org.freedesktop.impl.portal.FileChooser
              desktop = "niri"; # which xdg.portal.config entry gets the preference, "common" by default
            };
            settings = builtins.fromJSON (builtins.readFile ./dFiles-settings.json);
          };
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
    nixos = {
      programs.dsearch = {
        enable = true;
        systemd = {
          enable = true;
          target = "default.target";
        };
      };
    };
  };
}

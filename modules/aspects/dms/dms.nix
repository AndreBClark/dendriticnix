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
      url = "github:AvengeMedia/DankMaterialShell";
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
    includes = [
      den.aspects.dms.greeter
      den.aspects.dms.syncCmd
    ];
    homeManager =
      { user, pkgs, ... }:
      {
        imports = [
          inputs.dms.homeModules.dank-material-shell
          inputs.danksearch.homeModules.dsearch
          inputs.dms-plugin-registry.homeModules.default
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
            plugins =
              let
                rawPluginSettings = builtins.fromJSON (builtins.readFile ./plugin_settings.json);

                toPluginAttrs = lib.mapAttrs (
                  _: entry:
                  let
                    enable = entry.enabled or true;
                    settings = removeAttrs entry [ "enabled" ];
                  in
                  {
                    inherit enable settings;
                  }
                ) rawPluginSettings;
              in
              lib.mapAttrs (_: lib.mkDefault)
                {
                  airQuality.enable = true;
                  audioPortSwitcher.enable = true;
                  calculator.enable = true;
                  dankAudioVisualizer.enable = true;
                  dankBitwarden.enable = true;
                  dankObsidian.enable = true;
                  discordVoice.enable = true;
                  displayManager.enable = true;
                  dmsThemeSync.enable = true;
                  easyEffects.enable = true;
                  emojiLauncher.enable = true;
                  mediaPlayer.enable = true;
                  niriWindows.enable = true;
                  powerUsagePlugin.enable = true;
                  volumeMixer.enable = true;
                  wallpaperCarousel.enable = true;
                  wallpaperDiscovery.enable = true;
                  wallpaperShufflerPlugin.enable = true;
                  webSearch.enable = true;
                } // toPluginAttrs;
          };

          dsearch.enable = true;
        };
        # systemd.user.services.dms.Service.ExecStartPost =
        #   "${pkgs.dms-shell}/bin/dms ipc call profile setImage ${config.home.homeDirectory}/Pictures/Wallpaper-tokyo-night-dark/wallhaven.cc_nz1x2w.jpeg";
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

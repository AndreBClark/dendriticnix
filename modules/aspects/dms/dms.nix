{ lib, inputs, ... }:
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
    homeManager = {
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
          settings = lib.mkForce (builtins.fromJSON (builtins.readFile ./settings.json));
          plugins = {
            calculator.enable = true;
            mediaPlayer.enable = true;
            displayManager.enable = true;
            niriWindows.enable = true;
            powerUsagePlugin.enable = true;
            nixMonitor.enable = true;
            wallpaperDiscovery.enable = true;
            easyEffects.enable = true;
          };
        };

        dsearch.enable = true;
      };

    };
  };
}

{
  lib,
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.volantes-cursors
  ];
  xdg.configFile = {
    "niri/config.kdl".text = /* kdl */ ''
      include "dms-includes.kdl"
      include "window-rules.kdl"
      include "binds.kdl"
      include "layout.kdl"
      include "laptop-output.kdl"

      prefer-no-csd

      output "DP-2" {
        focus-at-startup
        variable-refresh-rate on-demand=true
      }
      output "HDMI-A-1" {
        position x=0 y=720
        variable-refresh-rate on-demand=true
      }

      workspace "1" {
        open-on-output "DP-2"
      }
      workspace "2" {
        open-on-output "HDMI-A-1"
      }
      workspace "3" { }
    '';

    "niri/layout.kdl".text =
      let
        gaps = "16";
        inset = "-${toString (lib.toIntBase10 gaps - 2)}";
      in
      /* kdl */ ''
        layout {
          gaps ${gaps}
          struts {
              left ${inset}
              right ${inset}
              top ${inset}
              bottom ${inset}
          }
          border {
            width 0
          }
        }
      '';
  };
}

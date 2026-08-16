{ inputs, ... }:
{
  flake-file.inputs = {
    millennium.url = "github:SteamClientHomebrew/Millennium/e2c66a276e579ee73c5151b01897bf63503aa12c?dir=packages/nix";
  };

  den.aspects.apps.steam = {
    nixos =
      { pkgs, ... }:
      {
        nixpkgs.overlays = [ inputs.millennium.overlays.default ];
        environment = {
          systemPackages = builtins.attrValues {
            inherit (pkgs)
              samrewritten
              sgdboop
              lsfg-vk-ui
              steamtinkerlaunch
              ;
          };
        };

        programs = {
          steam = {
            enable = true;
            package = pkgs.millennium-steam;
            remotePlay.openFirewall = true;
            protontricks.enable = true;
            localNetworkGameTransfers.openFirewall = true;
            extraPackages = builtins.attrValues {
              inherit (pkgs)
                gamescope
                mangohud
                winetricks
                faudio
                dxvk
                lsfg-vk
                ;
            };
            extraCompatPackages = builtins.attrValues {
              inherit (pkgs)
                proton-ge-bin
                steamtinkerlaunch
                steam-play-none
                ;
            };
          };
          gamescope = {
            enable = true;
            capSysNice = false;
            args = [
              "--force-windows-fullscreen"
              "-w 2560"
              "-h 1440"
              "--fullscreen"
              "--borderless"
              "--rt"
              "--disable-xres"
            ];

          };
          xwayland.enable = true;
          gamemode.enable = true;
        };
      };
  };
}

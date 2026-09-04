{ den, ... }:
{
  den.aspects.apps.steam = {
    includes = [
      (den.batteries.unfree [
        "steam"
        "steam-unwrapped"
      ])
    ];
    nixos =
      { pkgs, ... }:
      {
        environment = {
          systemPackages = builtins.attrValues {
            inherit (pkgs)
              samrewritten
              sgdboop
              ;
          };
        };

        programs = {
          steam = {
            enable = true;
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

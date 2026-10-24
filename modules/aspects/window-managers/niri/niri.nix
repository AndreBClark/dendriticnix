{ lib, den, ... }:
{
  den.aspects.niri =
    { user, ... }:
    {
      includes =
        builtins.attrValues {
          inherit (den.aspects.niri) config;
        }
        ++ lib.optionals (user.desktopShell == "dux") [
          den.aspects.dux.niri-includes
          den.aspects.dux
        ];

      nixos =
        { pkgs, ... }:
        {
          programs.niri.enable = true;
          environment = {
            variables.NIXOS_OZONE_WL = "1";
            systemPackages = builtins.attrValues {
              inherit (pkgs)
                libsecret
                ;
            };
          };
        };
      homeManager = {
        stylix.targets.kde.enable = false;
        wayland.windowManager.niri = {
          enable = true;
          systemd.enable = true;
          checkConfig = false;
        };
      };
    };
}

{ lib, den, ... }:
{
  den.aspects.niri =
    { user, ... }:
    {
      includes =
        builtins.attrValues {
          inherit (den.aspects.niri) config;
        }
        ++ lib.optionals (user.desktopShell == "dms") [
          den.aspects.dms.niri-includes
          den.aspects.dms
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
        wayland.windowManager.niri = {
          enable = true;
          systemd.enable = true;
        };
      };
    };
}

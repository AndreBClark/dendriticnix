{ den, ... }:
{
  den.aspects.hardware.storage =
    { host, ... }:
    {
      includes = map (t: den.aspects.hardware.storage.${t}) (host.hardware.storage or [ "ssd" ]);
      nixos =
        { pkgs, ... }:
        {
          services = {
            gvfs.enable = true;
            udisks2.enable = true;

            usbmuxd = {
              enable = true;
              package = pkgs.usbmuxd2;
            };
            fwupd.enable = true;
          };
          environment.systemPackages = builtins.attrValues {
            inherit (pkgs) libimobiledevice ifuse;
          };
        };
      homeManager = {
        services.udiskie.enable = true;
      };
    };
}

{ inputs, ... }:
{
  den.aspects.hardware.laptop = {
    nixos =
      { pkgs, ... }:
      {
        imports = [ inputs.hardware.nixosModules.common-pc-laptop-ssd ];
        hardware = {
          enableRedistributableFirmware = true;
          firmware = [
            pkgs.linux-firmware
          ];
          bluetooth.enable = true;
        };

        services = {
          upower.enable = true;
          blueman.enable = true;
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
  };
}

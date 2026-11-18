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
        };
      };
  };
}

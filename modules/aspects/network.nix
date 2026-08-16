{ lib, ... }:
{
  den.aspects.network = {
    nixos = {
      networking = {
        networkmanager.enable = true;
        useDHCP = lib.mkDefault true;
        stevenblack = {
          enable = true;
          block = [
            "fakenews"
            "gambling"
            "porn"
          ];
        };
      };
    };
  };
}

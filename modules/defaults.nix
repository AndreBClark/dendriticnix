{ lib, ... }: {
  den = {
    default = {
      nixos.system.stateVersion = "25.11";
      homeManager.home.stateVersion = "25.11";
      darwin.system.stateVersion = 6;
    };
    schema.user.classes = lib.mkDefault [ "homeManager" ];
  };
}

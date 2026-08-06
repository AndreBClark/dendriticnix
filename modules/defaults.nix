{ lib, ... }: {
  den = {
    default = {
      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            pkgs.git
            pkgs.nh
          ];
          networking.networkmanager.enable = true;
          services.pipewire.enable = true;
          security.rtkit.enable = true;
          xdg.portal.enable = true;
          system.stateVersion = "25.11";
          home-manager = {
            backupFileExtension = "backup";
            overwriteBackup = true;
          };
        };
      homeManager.home.stateVersion = "25.11";
      darwin.system.stateVersion = 6;
    };
    schema.user.classes = lib.mkDefault [ "homeManager" ];
  };
}

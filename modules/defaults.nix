{ lib, ... }: {
  den = {
    default = {
      nixos =
        { pkgs, ... }:
        {
          environment.systemPackages = [
            pkgs.git
          ];
          networking.networkmanager.enable = true;
          services.pipewire.enable = true;
          security.rtkit.enable = true;
          xdg.portal.enable = true;
          system.stateVersion = "25.11";
          home-manager = {
            useGlobalPkgs = true;
            backupFileExtension = "backup";
            overwriteBackup = true;
          };
          programs.nix-ld.enable = true;
        };
      homeManager.home.stateVersion = "25.11";
      darwin.system.stateVersion = 6;
    };
    schema.user.classes = lib.mkDefault [ "homeManager" ];
  };
}

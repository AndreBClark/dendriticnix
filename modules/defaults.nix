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
          system.stateVersion = "25.11";
          programs.nix-ld.enable = true;
        };
      darwin.system.stateVersion = 6;
    };
    schema = {
      user.classes = lib.mkDefault [ "homeManager" ];
      hm-host.includes = [
        {
          nixos.home-manager = {
            backupFileExtension = "backup";
            overwriteBackup = true;
          };
          homeManager.home.stateVersion = "25.11";
        }
      ];
    };
  };
}

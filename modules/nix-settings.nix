{
  den.default.nixos = {
    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        download-buffer-size = 524288000;
        substituters = [
          "https://niri.cachix.org"
          "https://devenv.cachix.org"
          "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
          "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
      extraOptions = "experimental-features = nix-command flakes";
    };
  };

  den.default.includes = [
    ({ user, ... }: {
      nixos.nix.settings.trusted-users = [ "admin" user.userName ];
    })
  ];
}

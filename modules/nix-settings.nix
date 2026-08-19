{
  den.default.nixos = {
    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        download-buffer-size = 524288000;
        substituters = [
          "https://cache.nixos.org"
          "https://nixos-search.cachix.org"
          "https://niri.cachix.org"
          "https://devenv.cachix.org"
          "https://nix-community.cachix.org"
          "https://hercules-ci.cachix.org"
          "https://static-rust-lang.cachix.org"
        ];

        extra-trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "nixos-search.cachix.org-1:1HV3YF8az4fywnH+pAd+CXFEdpTXtv9WpoivPi+H70o="
          "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "hercules-ci.cachix.org-1:7l2s0+56qrwLlQ7qJzGzJQpQZ8zLq0XJQJQJQJQJQJQ="
          "static-rust-lang.cachix.org-1:5s7k7l2s0+56qrwLlQ7qJzGzJQpQZ8zLq0XJQJQJQJQ="
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

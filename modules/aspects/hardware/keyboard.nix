{ lib, ... }: {
  den.aspects.keyboard = {
    homeManager =
      { user, ... }: {
        home.keyboard = user.keyboard;
      };
    nixos =
      { user, ... }:
      {
        services.xserver = {
          xkb = {
            inherit (user.keyboard) layout model variant;
            options = lib.concatStringsSep "," user.keyboard.options;
          };
        };
      };
  };
}

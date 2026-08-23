{
  den.aspects.keyboard = {
    homeManager = { user, ... }: {
      home = {
        inherit (user) keyboard;
      };
    };
    nixos =
      { user, ... }:
      {
        services.xserver.xkb = user.keyboard;
      };
  };
}

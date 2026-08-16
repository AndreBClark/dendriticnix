{
  den.aspects.keyboard = {
    nixos =
      { user, ... }:
      {
        services.xserver = {
          xkb = {
            inherit (user.keyboard) layout options model;
          };
        };
      };
  };
}

{ den, ... }:
{
  den.aspects.wm =
    { user, ... }:
    let
      inherit (user) windowManager;
    in
    {
      includes = [ den.aspects.${windowManager} ];
    };
}

{ den, ... }:
{
  den.aspects.wm =
    { user, ... }:
    let
      windowManager = user.windowManager or "niri";
    in
    {
      includes = [ den.aspects.wm.${windowManager} ];
    };
}

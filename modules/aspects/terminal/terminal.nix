{ den, ... }:
{
  den.aspects.terminal =
    { user, ... }:
    let
      inherit (user) terminal;
    in
    {
      includes = [ den.aspects.terminal.${terminal} ];
    };
}

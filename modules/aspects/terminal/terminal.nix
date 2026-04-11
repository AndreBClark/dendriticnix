{ den, ... }:
{
  den.aspects.terminal =
    { user, ... }:
    let
      terminalName = user.terminal or "kitty";
    in
    {
      includes = [ den.aspects.terminal.${terminalName} ];
    };
}

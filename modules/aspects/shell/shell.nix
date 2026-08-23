{ den, ... }:
{
  den.aspects.shell =
    { user, ... }:
    let
      inherit (user) shell;
    in
    {
      includes = [ den.aspects.shell.${shell} ];
    };
}

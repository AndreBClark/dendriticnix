{ den, ... }:
{
  den.aspects.shell =
    { user, ... }:
    let
      shell = user.shell or "fish";
    in
    {
      includes = [ den.aspects.shell.${shell} ];
    };
}

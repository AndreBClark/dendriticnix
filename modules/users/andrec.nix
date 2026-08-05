# modules/users/users.nix
{ den, ... }:
{
  den.aspects.andrec = {
    includes = [
      den.provides.primary-user
      den.aspects.base-user
      den.aspects.wm
      den.aspects.terminal
      den.aspects.shell
    ];
    user = {
      extraGroups = [
        "audio"
        "video"
        "greeter"
      ];
    };
  };
}

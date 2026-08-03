# modules/users/users.nix
{ den, ... }:
{
  den.aspects.andrec = {
    includes = [
      den.provides.primary-user
      den.aspects.base-user
      den.aspects.wm
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

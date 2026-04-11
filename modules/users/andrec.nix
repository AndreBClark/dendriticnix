# modules/users/users.nix
{ den, ... }:
{
  den.aspects.andrec = {
    includes = [
      den.provides.primary-user
      den.aspects.base-user
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

{ den, ... }:
{
  den.aspects.andrec = {
    includes = [
      den.provides.primary-user
      den.aspects.base-user

    ];
    user = { };
  };
}

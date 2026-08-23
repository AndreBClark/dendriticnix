{ den, ... }:
{
  den.aspects.andrec = {
    includes = [
      den.provides.primary-user
      den.aspects.base-user
      den.aspects.apps.spotify
    ];
    user = { };
    homeManager = {
      programs =
        {
          git = {
            signing.format = "openpgp";
            settings.user = {
              name = "AndreBClark";
              email = "andre@cosmicdivision.dev";
            };
          };
        };
    };
  };
}

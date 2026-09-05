{ den, ... }:
{
  den = {
    aspects.andrec = {
      includes = [
        den.provides.primary-user
        den.aspects.base-user
        den.aspects.apps.spotify
        den.aspects.apps.discord
      ];

      homeManager = {
        programs = {
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

    # find colorschems: https://tinted-theming.github.io/tinted-gallery/
    profiles.andrec = {
      theme.colorscheme = "tokyo-night-storm";
    };
  };
}

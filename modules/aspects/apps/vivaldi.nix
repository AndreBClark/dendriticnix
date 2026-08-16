{ den, ... }:
{
  den.aspects.apps.vivaldi =
    {
      includes = [
        (den.batteries.unfree [ "vivaldi" ])
      ];
      homeManager = {
        programs = {
          vivaldi = {
            enable = true;
            extensions = [
              {
                id = "lkbebcjgcmobigpeffafkodonchffocl";
                updateUrl = "https://gitlab.com/magnolia1234/bypass-paywalls-chrome-clean/-/raw/master/updates.xml";
              }
              { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # UBlock Origin
              { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # Sponsor Block
            ];
            commandLineArgs = [
              "--enable-features=UseOzonePlatform"
              "--ozone-platform-hint=auto"
            ];
          };
        };
      };
    };
}

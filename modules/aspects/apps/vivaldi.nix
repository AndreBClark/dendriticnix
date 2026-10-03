{ den, ... }:
{
  den.aspects.apps.vivaldi = {
    includes = [
      (den.batteries.unfree [
        "vivaldi"
        "widevine-cdm"
      ])
    ];
    homeManager =
      { pkgs, ... }:
      {
        programs = {
          vivaldi = {
            enable = true;
            package = pkgs.vivaldi.override {
              # uses chromium-codecs-ffmpeg-extra which didnt work?
              proprietaryCodecs = false;
              enableWidevine = true;
              inherit (pkgs) vivaldi-ffmpeg-codecs;
              commandLineArgs = [
                "--enable-features=UseOzonePlatform"
                "--ozone-platform-hint=auto"
              ];
            };
            extensions = [
              {
                id = "lkbebcjgcmobigpeffafkodonchffocl";
                updateUrl = "https://gitlab.com/magnolia1234/bypass-paywalls-chrome-clean/-/raw/master/updates.xml";
              }
              { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # UBlock Origin
              { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # Sponsor Block
            ];
          };
        };
      };
  };
}

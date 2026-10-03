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
              proprietaryCodecs = true;
              inherit (pkgs) vivaldi-ffmpeg-codecs;
              enableWidevine = true;
            };
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
        home.packages = builtins.attrValues {
          inherit (pkgs.gst_all_1)
            gstreamer
            gst-plugins-base
            gst-plugins-bad
            gst-plugins-ugly
            gst-plugins-good
            gst-libav
            ;
        };
      };
  };
}

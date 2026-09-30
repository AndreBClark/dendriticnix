{ den, ... }:
{
  den.aspects.audio-production = {
    includes = [
      den.aspects.hardware.audio
      den.aspects.apps.audacity
      den.aspects.folders.audio-production
    ];
    provides.to-users.includes = [ den.aspects.apps.audacity ];
  };
  den.aspects.folders.audio-production = {
    homeManager =
      { config, ... }:
      {
        xdg.userDirs.extraConfig.AUDIO = "${config.home.homeDirectory}/audio";
      };
  };

}

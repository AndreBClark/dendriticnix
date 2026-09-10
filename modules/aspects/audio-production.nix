{ den, ... }:
{
  den.aspects.audio-production = {
    includes = [
      den.aspects.hardware.audio
      den.aspects.apps.audacity
    ];
  };
}

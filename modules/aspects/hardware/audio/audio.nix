{ lib, ... }:
{
  den.aspects.audio = {
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = builtins.attrValues {
          inherit (pkgs)
            rnnoise-plugin
            pwvucontrol
            easyeffects
            ;
        };
        security.rtkit.enable = true;
        services = {
          pulseaudio.enable = false;
          pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
          };
        };
      };
    homeManager = {
      services.easyeffects = {
        enable = true;
        extraPresets = {
          NPR = lib.importJSON ./Masc_NPR_VOICE.json;
          Military = lib.importJSON ./Military_Comm.json;
        };
      };
    };
  };
}

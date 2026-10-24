{ den, ... }:
{
  den.aspects = {
    base-user = {
      includes = builtins.attrValues {
        inherit (den.batteries) define-user;
        inherit (den.aspects)
          minimal-user
          folders
          wm
          ;
        inherit (den.aspects.apps)
          vivaldi
          obsidian
          ;
      };
      # Base OS-level user settings
      user = {
        extraGroups = [
          "wheel"
          "networkmanager"
          "audio"
          "video"
          "greeter"
        ];
      };

      homeManager = { };
    };
  };
}

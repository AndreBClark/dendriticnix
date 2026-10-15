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
          nautilus
          vivaldi
          obsidian
          ;
      };
      # Base OS-level user settings
      user = {
        initialPassword = "yolo";
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

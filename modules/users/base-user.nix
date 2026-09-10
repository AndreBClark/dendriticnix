{ den, ... }:
{
  den.aspects.base-user = {
    includes = builtins.attrValues {
      inherit (den.batteries) define-user;
      inherit (den.aspects)
        shell
        folders
        stylix
        wm
        development
        ;
      inherit (den.aspects.apps)
        nautilus
        vivaldi
        superfile
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
}

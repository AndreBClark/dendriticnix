{ den, ... }:
{
  den.aspects.base-user = {
    includes = builtins.attrValues {
      inherit (den.batteries) define-user;
      inherit (den.aspects)
        folders
        stylix
        wm
        terminal
        shell
        cli
        nvim
        my-packages
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

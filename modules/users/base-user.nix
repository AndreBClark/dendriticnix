{ den, ... }:
{
  den.aspects.base-user = {
    includes = builtins.attrValues {
      inherit (den.aspects)
        folders
        stylix
        wm
        terminal
        shell
        cli
        nvim
        ;
      inherit (den.aspects.apps)
        nautilus
        vivaldi
        superfile
        obsidian
        ;
      inherit (den.batteries) define-user;
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

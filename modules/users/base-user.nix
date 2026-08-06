{ den, ... }:
{
  den.aspects.base-user = {
    includes = [
      den.provides.define-user
      den.aspects.stylix
      den.aspects.wm
      den.aspects.terminal
      den.aspects.shell
      den.aspects.cli
    ];

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

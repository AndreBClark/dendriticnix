{ den, ... }:
{
  den.aspects.base-user = {
    includes = [
      den.provides.define-user
      den.aspects.folders
      den.aspects.stylix
      den.aspects.wm
      den.aspects.terminal
      den.aspects.shell
      den.aspects.cli
      den.aspects.nvim
      den.aspects.apps.nautilus
      den.aspects.apps.vivaldi
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

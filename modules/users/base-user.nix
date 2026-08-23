{ __findFile, ... }:
{
  den.aspects.base-user = {
    includes = [
      <den/define-user>
      <folders>
      <stylix>
      <wm>
      <terminal>
      <shell>
      <cli>
      <nvim>
      <apps/nautilus>
      <apps/vivaldi>
      <apps/superfile>
      <apps/obsidian>
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

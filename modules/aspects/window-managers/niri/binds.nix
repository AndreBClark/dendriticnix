{
  den.aspects.niri.binds = {
    homeManager =
      { user, ... }:
      {
        wayland.windowManager.niri.settings = {
          _children = [
            {
              binds = {
                "Mod+T" = {
                  _props.hotkey-overlay-title = "Open Terminal";
                  spawn-sh = user.terminal;
                };
                "Alt+Y" = {
                  _props.hotkey-overlay-title = "Toggle wallpaper Carousel";
                  spawn-sh = "dms ipc wallpaperCarousel toggle";
                };
              };
            }
          ];
        };
      };
  };
}

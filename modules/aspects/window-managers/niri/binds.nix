{
  den.aspects.wm.niri = {
    homeManager = {
      wayland.windowManager.niri.settings = {
        _children = [{
          binds."Mod+T" = {
            _props.hotkey-overlay-title = "Open Terminal";
            spawn-sh = "$TERMINAL";
          };
        }];
      };
    };
  };
}

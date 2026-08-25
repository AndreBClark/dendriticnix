{
  den.aspects.niri.config = {
    homeManager =
      { user, ... }:
      {
        wayland.windowManager.niri = {
          settings = {
            input.keyboard.xkb = user.keyboard;

            hotkey-overlay = {
              skip-at-startup = true;
              hide-not-bound = true;
            };

            blur = {
              offset = 4;
              passes = 4;
              noise = 0.03;
            };

            prefer-no-csd = { };

            layout = {
              gaps = 16;
              struts = {
                left = -14;
                right = -14;
                top = -14;
                bottom = -14;
              };
              border.width = 0;
            };

            _children = [
              {
                layer-rule = {
                  _children = [
                    { match._props.namespace = "dms:blurwallpaper"; }
                    { place-within-backdrop = true; }
                  ];
                };
              }
              {
                workspace = {
                  _args = [ "1" ];
                };
              }
              {
                workspace = {
                  _args = [ "2" ];
                };
              }
              {
                workspace = {
                  _args = [ "3" ];
                };
              }
            ];

          };
        };
      };
  };
}

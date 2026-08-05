{
  den.aspects.wm.niri = {
    homeManager =
      { user, ... }:
      {
        wayland.windowManager.niri =
          {
            settings = {
              input.keyboard.xkb = {
                layout = user.keyboard.layout;
                model = user.keyboard.model;
                options = user.keyboard.options;
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

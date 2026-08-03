{
  den.aspects.wm.niri = {
    homeManager =
      { user, ... }:
      {
        wayland.windowManager.niri = {
          settings = {
            input.keyboard.xkb = {
              layout = user.keyboard.layout;
              model = user.keyboard.model;
              options = user.keyboard.options;
            };

            prefer-no-csd = { };

            _children = [
              {
                output = {
                  _args = [ "DP-2" ];
                  focus-at-startup = { };
                  variable-refresh-rate._props.on-demand = true;
                };
              }
              {
                output = {
                  _args = [ "HDMI-A-1" ];
                  position._props = {
                    x = 0;
                    y = 720;
                  };
                  variable-refresh-rate._props.on-demand = true;
                };
              }
              {
                workspace = {
                  _args = [ "1" ];
                  open-on-output = "DP-2";
                };
              }
              {
                workspace = {
                  _args = [ "2" ];
                  open-on-output = "HDMI-A-1";
                };
              }
              {
                workspace = {
                  _args = [ "3" ];
                };
              }
            ];

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
          };
        };
      };
  };
}

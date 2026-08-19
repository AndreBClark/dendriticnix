{ den, ... }:
{
  den.aspects.niri = {
    dragonfly-output = {
      homeManager.wayland.windowManager.niri.settings._children = [
        {
          output = {
            _args = [ "eDP-1" ];
            mode._props.custom = true;
            mode._args = [ "1920x1080@60" ];
            scale = 1.0;
          };
        }
      ];
    };

    seadragon-output = {
      homeManager.wayland.windowManager.niri.settings._children = [
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
            position._props = { x = 0; y = 720; };
            variable-refresh-rate._props.on-demand = true;
          };
        }
      ];
    };

    # Optional dispatcher, parametric on host — activates only in {host} contexts
    outputs = { host, ... }: {
      includes = [
        (if host.name == "dragonfly" then den.aspects.niri.dragonfly-output
        else if host.name == "seadragon" then den.aspects.niri.seadragon-output
        else { })
      ];
    };
  };
}

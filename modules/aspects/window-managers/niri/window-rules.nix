{
  den.aspects.wm.niri = {
    homeManager = { user, ... }: {
      wayland.windowManager.niri.settings._children = [
        {
          window-rule = {
            opacity = user.theme.opacity.applications;
            background-effect = {
              blur = true;
              xray = true;
            };
          };
        }
        {
          window-rule._children = [
            { match._props.app-id = "(?i)Bitwarden"; }
            { match._props.title = "(?i)$Bitwarden^"; }
            { open-maximized = false; }
            { open-floating = true; }
          ];
        }
        {
          window-rule._children = [
            { match._props.title = "(?i)^Picture in picture$"; }
            { match._props.title = "(?i)^Picture-in-Picture$"; }
            { open-floating = true; }
            { opacity = 1.0; }
            { background-effect.blur = false; }
            { open-maximized = false; }
            { default-column-width.proportion = 0.25; }
            { default-window-height.proportion = 0.25; }
            {
              default-floating-position._props = {
                x = 50;
                y = 50;
                relative-to = "bottom-right";
              };
            }
          ];
        }
        {
          window-rule._children = [
            {
              match._props = {
                app-id = "(?i)^steam$";
                title = "(?i)^Steam$";
              };
            }
            { open-maximized = true; }
          ];
        }
        {
          window-rule._children = [
            { match._props.app-id = "steam_app_\\d+"; }
            { open-floating = true; }
            { open-maximized = true; }
            { open-on-output = "DP-2"; }
            { open-on-workspace = "2"; }
            { opacity = 1.0; }
          ];
        }
        {
          window-rule._children = [
            { match._props.app-id = "(?i)spotify"; }
            { open-on-workspace = "3"; }
            { open-on-output = "HDMI-A-1"; }
            { open-maximized = true; }
            { opacity = 0.8; }
          ];
        }
        {
          window-rule._children = [
            { match._props.app-id = "org.gnome.NautilusPreviewer"; }
            { open-floating = true; }
            { opacity = 1.0; }
          ];
        }
      ];
    };
  };
}

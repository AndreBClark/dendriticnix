{
  den.aspects.niri.config = {
    homeManager =
      { user, host, ... }:
      {
        wayland.windowManager.niri =
          let
            mkIncludes =
              files:
              map (f: {
                include = {
                  _args = [ f ];
                  _props.optional = true;
                };
              }) files;
          in
          {
            settings._children = mkIncludes [
              "layout.kdl"
              "input.kdl"
              "window-rules.kdl"
              "binds.kdl"
              "output-${host.name}"
            ];
          };
        xdg.configFile =
          let
            mkConfigFile =
              {
                path,
                variables,
                values,
              }:
              builtins.replaceStrings variables values (builtins.readFile path);
          in
          {
            "niri/layout.kdl".source = ./layout.kdl;

            "niri/input.kdl".text = mkConfigFile {
              path = ./input.kdl;
              variables = [
                "@@XKB_LAYOUT"
                "@@XKB_VARIANT@@"
                "@@XKB_OPTIONS@@"
              ];
              values = [
                user.keyboard.layout
                user.keyboard.variant
                user.keyboard.options
              ];
            };
            "niri/binds.kdl".text = mkConfigFile {
              path = ./binds.kdl;
              variables = [ "@@TERMINAL@@" ];
              values = [ user.terminal ];
            };
            "niri/window-rules.kdl".text = mkConfigFile {
              path = ./window-rules.kdl;
              variables = [ "@@OPACITY_APPLICATIONS@@" ];
              values = [ (toString user.theme.opacity.applications) ];
            };
            "niri/output-${host.name}.kdl".source = ./output-${host.name}.kdl;
          };
      };
  };
}

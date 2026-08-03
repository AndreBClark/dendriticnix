{ den, ... }:
{
  den.aspects.base-user = {
    includes = [
      den.provides.define-user
      (den.provides.user-shell "fish")
    ];

    # Base OS-level user settings
    user = {
      initialPassword = "yolo";
    };
    homeManager = {
      home.sessionVariables = {
        TERMINAL = "kitty";
        EDITOR = "nvim";
      };
    };
  };
}

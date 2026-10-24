{ den, lib, ... }:
{
  den.aspects = {
    minimal-user = {
      includes = builtins.attrValues {
        inherit (den.batteries) define-user;
        inherit (den.aspects)
          shell
          theme
          development
          ;
        inherit (den.aspects.apps)
          superfile
          ;
      };

      user.initialPassword = "yolo";

      homeManager = {
        xdg.userDirs.enable = lib.mkDefault false;
      };
    };
  };
}

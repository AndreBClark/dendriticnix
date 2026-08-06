{
  den.aspects.cli.provides.eza = {
    homeManager = {
      programs.eza = {
        enable = true;
        icons = "auto";
        colors = "always";
        extraOptions = [
          "--classify"
          "--group-directories-first"
          "--header"
          "--mounts"
          "--smart-group"
          "--no-permissions"
          "--no-user"
        ];
      };
    };
  };
}

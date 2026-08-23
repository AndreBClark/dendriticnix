{ den, ... }:
{
  den.aspects.cli.eza = {
    includes = [
      (den.batteries.shell-integrations [ "eza" ])
    ];
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

      home.shellAliases = {
        ls = "eza";
        ll = "eza -l";
        la = "eza -A";
        tree = "eza --tree --level 2";
      };

    };
  };
}

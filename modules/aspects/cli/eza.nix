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
        git = true;
        colors = "always";
        extraOptions = [
          "--classify"
          "--group-directories-first"
          "--header"
          "--mounts"
          "--smart-group"
          "--no-permissions"
          "--no-user"
          "--short-nix"
          "--follow-symlinks"
        ];
      };

      home.shellAliases = {
        tree = "eza --tree --level 2";
      };

    };
  };
}

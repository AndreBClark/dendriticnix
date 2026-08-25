{ den, ... }:
{
  den.aspects.cli = {
    includes = builtins.attrValues {
      inherit (den.aspects.cli)
        devenv
        eza
        fzf
        git
        lazygit
        nh
        tmux
        zoxide
        ;
    };

    homeManager =
      { pkgs, ... }:
      {
        home.packages = builtins.attrValues {
          inherit (pkgs) code2prompt;
        };

      };
  };
}

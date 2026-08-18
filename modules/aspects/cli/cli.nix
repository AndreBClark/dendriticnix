{ den, ... }:
{
  den.aspects.cli = {
    includes = [
      den.aspects.cli.devenv
      den.aspects.cli.eza
      den.aspects.cli.fzf
      den.aspects.cli.git
      den.aspects.cli.lazygit
      den.aspects.cli.nh
      den.aspects.cli.tmux
      den.aspects.cli.zoxide
    ];
    homeManager =
      { pkgs, ... }:
      {
        home.packages = builtins.attrValues {
          inherit (pkgs) code2prompt;
        };

      };
  };
}

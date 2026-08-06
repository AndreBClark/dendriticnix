{ den, ... }:
{
  den.aspects.cli.includes = [
    den.aspects.cli.git
    den.aspects.cli.lazygit
    den.aspects.cli.fzf
    den.aspects.cli.tmux
    den.aspects.cli.yazi
    den.aspects.cli.eza
    den.aspects.cli.zoxide
  ];
}

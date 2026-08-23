{ __findFile, ... }:
{
  den.aspects.cli = {
    includes = [
      <cli/devenv>
      <cli/eza>
      <cli/fzf>
      <cli/git>
      <cli/lazygit>
      <cli/nh>
      <cli/tmux>
      <cli/zoxide>
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

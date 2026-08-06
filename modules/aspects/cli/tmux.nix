{
  den.aspects.cli.provides.tmux = {
    homeManager =
      { pkgs, user, ... }:
      {
        programs.tmux = {
          inherit (user) terminal;
          enable = true;
          keyMode = "vi";
          tmuxinator.enable = true;
          customPaneNavigationAndResize = true;
          plugins = builtins.attrValues {
            inherit (pkgs.tmuxPlugins)
              vim-tmux-navigator
              sensible
              ;
          };
        };
      };
  };
}

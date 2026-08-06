{
  den.aspects.cli.provides.lazygit = {
    homeManager = {
      programs.lazygit = {
        enable = true;
        settings = {
          gui = {
            mouseEvents = false;
            showFileTree = true;
            nerdFontsVersion = "3";
            showFileIcons = true;
            skipDiscardChangeWarning = true;
          };
          git = {
            pagers = [
              { pager = "delta --paging=never --dark --syntax-theme=base16-stylix --line-numbers --hyperlinks"; }
            ];
            autoFetch = false;
            diffContextSize = 5;
            parseEmoji = true;
            mainBranches = [
              "main"
              "master"
            ];
            skipHookPrefix = "WIP";
            commit = {
              autoWrapCommitMessage = true;
              autoWrapWidth = 72;
              signOff = false;
            };
          };
        };
      };
    };
  };
}

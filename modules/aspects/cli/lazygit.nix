{ den, ... }:
{
  den.aspects.cli.lazygit = {
    includes = [
      (den.batteries.shell-integrations [ "lazygit" ])
    ];

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
            showNumstatInFilesView = true;
            showDivergenceFromBaseBranch = "arrowAndNumber";
          };

          git = {
            diffRenderers = [
              { command = "delta"; }
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
              signOff = true;
            };

          };
        };
      };
    };
  };
}

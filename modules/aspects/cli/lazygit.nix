{ lib, den, ... }:
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
            expandFocusedSidePanel = true;
            expandedSidePanelWeight = 3;
            commitAuthorLongLength = 17;
            commitAuthorShortLength = 7;
            commitHashLength = 6;
          };

          git = {
            diffRenderers = [
              {
                command = lib.concatStringsSep " " [
                  "delta"
                  "--hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\""
                ];
              }
            ];

            autoFetch = false;
            diffContextSize = 7;
            parseEmoji = true;
            autoRefresh = true;
            autoDetectExternalChanges = true;
            autoStageResolvedConflicts = true;
            ignoreWhitespaceInDiffView = true;
            renameSimilarityThreshold = 50;
            localBranchSortOrder = "recency";

            log = {
              order = "topo-order";
              showWholeGraph = true;
            };

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

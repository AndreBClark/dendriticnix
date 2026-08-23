{
  den.aspects.cli.git = {
    homeManager = {
      programs = {
        git = {
          enable = true;
          settings = {
            merge = {
              conflictStyle = "zdiff3";
            };

            push = {
              autoSetupRemote = true;
            };

            pull = {
              rebase = true;
            };

            advice = {
              addIgnoredFile = false;
            };

            init.defaultBranch = "main";
            stash.showIncludeUntracked = true;

            status = {
              short = true;
              branch = true;
              showStash = true;
              showUntrackedFiles = "all";
            };
          };
        };

        delta = {
          enable = true;
          enableGitIntegration = true;
          options = {
            paging = "never";
            dark = true;
            syntax-theme = "base16-stylix";
            hyperlinks = true;
            line-numbers = true;
          };
        };

        gh = {
          enable = true;
          gitCredentialHelper.enable = true;
        };
      };
    };
  };
}

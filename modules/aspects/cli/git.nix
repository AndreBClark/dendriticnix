{
  den.aspects.cli.provides.git = {
    homeManager = {
      programs = {
        git = {
          enable = true;
          signing.format = "openpgp";
          settings = {
            user = {
              name = "AndreBClark";
              email = "andre@cosmicdivision.dev";
            };
            delta = {
              diff-so-fancy = true;
              line-numbers = true;
              navigate = true;
              side-by-side = true;
            };
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
            syntax-theme = "base16-stylix";
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

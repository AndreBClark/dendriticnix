{
  den.aspects.apps.superfile = {
    nixos = { };
    homeManager = {
      programs.superfile = {
        enable = true;
        firstUseCheck = false;
        # pinnedFolders = { };
        settings = {
          default_directory = "~";
          code_previewer = "bat";
          nerdfont = true;
          metadata = true;
          zoxide_support = true;
        };
        themes = { };
      };
    };
  };
}

{
  den.aspects.apps.obsidian = {
    homeManager =
      {
        programs.obsidian = {
          enable = true;
          defaultSettings = {
            app = {
              vimMode = true;
            };

            appearance = {
              theme = "vauxhall";
              css = "vauxhall";
            };

            communityPlugins = [
              "style-settings"
              "dataview"
              "templater"
            ];
          };
        };
      };
  };
}

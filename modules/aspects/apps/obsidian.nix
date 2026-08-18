{ den, ... }:
{
  den.aspects.apps.obsidian = {
    includes = [
      (den.batteries.unfree [ "obsidian" ])
    ];
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

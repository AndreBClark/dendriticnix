{ lib, ... }:
{
  den.aspects.folders = {
    homeManager =
      { config, ... }:
      let
        homeDir = config.home.homeDirectory;
        directories = [
          {
            path = "vaults";
            icon = "folder-obsidian";
          }
          {
            path = "repos";
            icon = "folder-github";
          }
          {
            path = "audio";
            icon = "folder-music";
          }
        ];

        mkDirectoryFile = dir: {
          name = "${dir.path}/.directory";
          value = {
            text = ''
              [Desktop Entry]
              Icon=${dir.icon}
            '';
          };
        };
        mkLink = target: {
          source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/${target}";
        };
      in
      {
        xdg.userDirs = {
          enable = true;
          createDirectories = true;
          setSessionVariables = true;
          desktop = null;
          templates = null;
          publicShare = null;
          projects = null;
        };
        xdg.dataFile."mime/packages/inode-directory.xml".text = ''
          <?xml version="1.0" encoding="utf-8"?>
          <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
            <mime-type type="inode/directory">
              <comment>Folder</comment>
              <icon name="folder"/>
              <glob-deleteall/>
            </mime-type>
          </mime-info>
        '';
        home = {
          file = lib.listToAttrs (map mkDirectoryFile directories) // {
            "config" = mkLink ".config";
            "local-share" = mkLink ".local/share";
          };
        };

      };
  };
}

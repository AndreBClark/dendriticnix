{ lib, ... }:
{
  den.aspects.folders = {
    homeManager =
      {
        host,
        pkgs,
        config,
        ...
      }:

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
        ]
        ++ lib.optionals (host.name == "dragonfly") [
          {
            path = "audio";
            icon = "folder-sound";
          }
        ];

        mkDirectoryFile = dir: {
          name = "${homeDir}/${dir.path}/.directory";
          value = {
            text = ''
              [Desktop Entry]
              Icon=${dir.icon}
            '';
          };
        };
        mkLink = target: {
          source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${target}";
        };
      in
      {
        home = {
          packages = [ pkgs.xdg-user-dirs ];
          file = lib.listToAttrs (map mkDirectoryFile directories) // {
            "config" = mkLink ".config";
            "local-share" = mkLink ".local/share";
          };
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
      };
  };
}

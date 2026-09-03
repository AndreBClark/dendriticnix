{
  den.aspects.apps.superfile = {
    nixos = { };
    homeManager =
      { user, config, ... }:
      {
        programs.superfile = {
          enable = true;
          firstUseCheck = false;
          pinnedFolders =
            let
              homeDir = config.home.homeDirectory;
            in
            [
              {
                name = " nixconfig";
                location = "${homeDir}/nixconfig";
              }
              {
                name = " Repos";
                location = "${homeDir}/repos";
              }
              {
                name = "󰉏 Pictures";
                location = "${homeDir}/Pictures";
              }
              {
                name = " Lunarium";
                location = "${homeDir}/lunarium";
              }
            ];
          settings = {
            inherit (user) editor;
            dir_editor = "";
            auto_check_update = false;
            cd_on_quit = false;
            default_open_file_preview = true;
            show_image_preview = true;
            show_panel_footer_info = true;
            default_directory = "~";
            file_size_use_si = false;
            default_sort_type = 0;
            sort_order_reversed = false;
            case_sensitive_sort = false;
            shell_close_on_success = false;
            debug = false;
            ignore_missing_fields = true;
            nerdfont = true;
            transparent_background = true;
            file_preview_width = 0;
            code_previewer = "bat";
            sidebar_width = 20;
            metadata = true;
            zoxide_support = true;
            enable_md5_checksum = false;
          };
          themes = { };
        };
        home.shellAliases = {
          spf = "superfile";
        };
      };
  };
}

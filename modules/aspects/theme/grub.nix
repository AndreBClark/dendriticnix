{ lib, inputs, ... }:
{
  den.aspects.theme.grub.nixos =
    {
      pkgs,
      config,
      options,
      ...
    }:
    {
      config = lib.optionalAttrs (options ? boot && options ? stylix) (
        let
          stylixModule = import "${inputs.stylix}/modules/grub/nixos.nix" {
            inherit pkgs config lib;
          };
          colors = config.lib.stylix.colors.withHashtag;
          font = config.stylix.fonts.monospace.name;
          stylixTheme = stylixModule.config.boot.loader.grub.content.theme;

          # cached separately — rebuilds only if size/source changes
          logo = pkgs.runCommand "grub-logo" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
            magick ${pkgs.nixos-icons}/share/icons/hicolor/512x512/apps/nix-snowflake.png \
              -background none -gravity center -extent 512x512 -depth 8 PNG32:$out
          '';

          # clean theme.txt: transform the stylix output, keep it inspectable
          themeTxt =
            with colors;
            pkgs.writeText "theme.txt" ''
              desktop-image: "background.png"
              desktop-image-scale-method: "crop"
              desktop-color: "${base00}"

              title-text: ""

              terminal-left: "10%"
              terminal-top: "20%"
              terminal-width: "80%"
              terminal-height: "60%"

              + progress_bar {
                left = 25%
                top = 80%+20
                width = 50%
                height = 30

                id = "__timeout__"
                show_text = true
                font = "${font}"
                text = "@TIMEOUT_NOTIFICATION_MIDDLE@"

                border_color = "${base00}"
                bg_color = "${base00}"
                fg_color = "${base0B}"
                text_color = "${base00}"
              }

              + boot_menu {
                left = 50%
                top = 20%
                width = 40%
                height = 60%
                menu_pixmap_style = "background_*.png"

                item_height = 40
                item_icon_space = 8
                item_spacing = 0
                item_padding = 0
                item_font = "${font}"
                item_color = "${base05}"

                selected_item_color = "${base01}"
                selected_item_pixmap_style = "selection_*.png"
              }
              + image {
                left = 25%-256
                top = 50%-256
                file = "logo.png"
              }
            '';
        in
        {
          boot.loader.grub.theme = lib.mkForce (
            pkgs.runCommand "my-grub-theme" { } ''
              mkdir $out
              cp -r ${stylixTheme}/* $out/
              chmod -R u+w $out
              rm $out/theme.txt
              cp ${themeTxt} $out/theme.txt
              cp ${logo} $out/logo.png
            ''
          );
        }
      );
    };
}

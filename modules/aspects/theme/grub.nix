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
          stylixTheme = stylixModule.config.boot.loader.grub.content.theme;

          # cached separately — rebuilds only if size/source changes
          logo = pkgs.runCommand "grub-logo" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
            magick ${pkgs.nixos-icons}/share/icons/hicolor/512x512/apps/nix-snowflake.png \
              -resize 360x360 -background none -gravity center -extent 360x360 \
              $out
          '';

          # clean theme.txt: transform the stylix output, keep it inspectable
          themeTxt = pkgs.runCommand "grub-theme.txt" { } ''
            awk '
              /^\+ boot_menu \{/ { inmenu = 1 }
              inmenu && /left = 25%/  { sub(/25%/, "50%") }
              inmenu && /width = 50%/ { sub(/50%/, "40%") }
              inmenu && /^\}/         { inmenu = 0 }
              { print }
            ' ${stylixTheme}/theme.txt > $out

            cat >> $out <<'EOF'
            + image {
              left = 15%
              top = 25%
              file = "logo.png"
            }
            EOF
          '';
        in
        {
          boot.loader.grub.theme = lib.mkForce (
            pkgs.runCommand "my-grub-theme" { } ''
              mkdir $out
              cp -r ${stylixTheme}/* $out/
              chmod -R u+w $out
              cp ${themeTxt} $out/theme.txt
              cp ${logo} $out/logo.png
            ''
          );
        }
      );
    };
}

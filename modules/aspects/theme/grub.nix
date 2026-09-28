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
          # unwrap lib.mkIf -> real theme drv (background, fonts, pixmaps, theme.txt)
          stylixTheme = stylixModule.config.boot.loader.grub.content.theme;
        in
        {
          # stylix grub target stays ENABLED — this only replaces `theme`
          boot.loader.grub.theme = lib.mkForce (
            pkgs.runCommand "my-grub-theme" { } ''
              mkdir $out
              cp -r ${stylixTheme}/* $out/
              chmod -R u+w $out

              # shift the existing boot_menu to the right column
              awk '
                /^\+ boot_menu \{/ { inmenu = 1 }
                inmenu && /left = 25%/  { sub(/25%/, "50%") }
                inmenu && /width = 50%/ { sub(/50%/, "40%") }
                inmenu && /^\}/         { inmenu = 0 }
                { print }
              ' $out/theme.txt > $out/theme.txt.new
              mv $out/theme.txt.new $out/theme.txt

              # left column: big OS logo; also move the timeout bar under the menu
              cat >> $out/theme.txt <<'EOF'
              + image {
                left = 12%
                top = 25%
                width = 30%
                height = 50%
                file = "logo.png"
              }
              EOF

              sed -i 's/^  left = 25%$/  left = 50%/; s/^  width = 50%$/  width = 40%/' $out/theme.txt

              cp ${pkgs.nixos-icons}/share/icons/hicolor/512x512/apps/nix-snowflake.png $out/logo.png
            ''
          );
        }
      );
    };
}

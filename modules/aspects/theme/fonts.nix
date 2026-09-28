{ den, lib, ... }:
{
  den.lib.theme.stylixFonts =
    { pkgs, theme }:
    let
      resolve = f: {
        inherit (f) name;
        package = lib.getAttrFromPath (lib.splitString "." f.package) pkgs;
      };
    in
    lib.mapAttrs (_: resolve) (removeAttrs theme.fonts [ "sizes" ]) // { inherit (theme.fonts) sizes; };

  den.aspects.theme.fonts =
    { user, ... }:
    let
      theme = den.lib.theme.resolveTheme { inherit user; };

      fontModule = pkgs: {
        stylix = {
          fonts = den.lib.theme.stylixFonts { inherit pkgs theme; };
          targets = {
            font-packages.enable = true;
            fontconfig.enable = true;
          };
        };
      };
    in
    {
      nixos = { pkgs, ... }: {
        fonts.enableDefaultPackages = true;
        inherit (fontModule pkgs) stylix;
      };

      homeManager = { pkgs, ... }: fontModule pkgs;
    };
}

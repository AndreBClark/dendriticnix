{
  den.aspects.cli.bat =
    let
      settings = {
        map-syntax = [ "*.astro:TypeScriptReact" ];
        style = "numbers,changes,header,header-filesize";
        color = "always";
        theme = "base16-stylix";
      };
      extraPackages =
        pkgs:
        builtins.attrValues {
          inherit (pkgs.bat-extras)
            batgrep
            batman
            batdiff
            ;
        };

    in
    {
      nixos =
        { pkgs, ... }:
        {
          programs.bat = {
            enable = true;
            inherit settings;
            extraPackages = extraPackages pkgs;

          };
        };

      homeManager =
        { pkgs, ... }:
        {
          programs.bat = {
            enable = true;
            config = settings;
            extraPackages = extraPackages pkgs;
          };
        };
    };
}

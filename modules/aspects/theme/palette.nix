{ inputs, den, ... }:
{
  flake-file.inputs.base16.url = "github:SenchoPens/base16.nix";

  den.lib.theme = {
    resolveTheme =
      { user }:
      den.profiles.${user.name}.theme or user.theme;

    scheme =
      {
        pkgs,
        lib,
        user,
      }:
      let
        base16 = inputs.base16.lib { inherit pkgs lib; };
        theme = den.lib.theme.resolveTheme { inherit user; };
        fallbackScheme = "tokyo-night-moon";
        attempt = builtins.tryEval (base16.mkSchemeAttrs theme.colorscheme);
      in
      if attempt.success then attempt.value else base16.mkSchemeAttrs fallbackScheme;

    palette =
      {
        pkgs,
        lib,
        user,
        withHashtag ? true,
      }:
      let
        s = den.lib.theme.scheme { inherit pkgs lib user; };
        full = if withHashtag then s.withHashtag else s;
      in
      lib.getAttrs [
        "base00"
        "base01"
        "base02"
        "base03"
        "base04"
        "base05"
        "base06"
        "base07"
        "base08"
        "base09"
        "base0A"
        "base0B"
        "base0C"
        "base0D"
        "base0E"
        "base0F"
      ] full;
  };
}

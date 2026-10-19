{
  den.aspects.theme.icons =
    let
      papirus-dracula-blend = _: prev: {
        papirus-icon-theme = (prev.papirus-icon-theme.override { color = "indigo"; }).overrideAttrs (_: {
          dontFixup = true;
        });
      };
    in
    {
      nixos = {
        nixpkgs.overlays = [
          papirus-dracula-blend
        ];
      };
      homeManager = {
        nixpkgs.overlays = [
          papirus-dracula-blend
        ];
      };
    };
}

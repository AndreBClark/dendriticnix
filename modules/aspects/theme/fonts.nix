{
  den.aspects.theme.fonts =
    let
      stylixFonts =
        pkgs:
        let
          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono Nerd Font";
          };
        in
        {
          fonts = {
            inherit monospace;
            serif = monospace;
            sansSerif = monospace;
            emoji = {
              name = "Noto Emoji";
              package = pkgs.noto-fonts-monochrome-emoji;
            };
          };
          targets = {
            font-packages.enable = true;
            fontconfig.enable = true;
          };
        };
      fontPackages = pkgs: [
        pkgs.nerd-fonts.symbols-only
        pkgs.noto-fonts
        pkgs.unifont
        pkgs.freefont_ttf
        pkgs.liberation_ttf
        pkgs.noto-fonts-color-emoji
        pkgs.noto-fonts-monochrome-emoji
      ];
    in
    {
      nixos =
        { pkgs, ... }:
        {
          stylix = stylixFonts pkgs;
          fonts.enableDefaultPackages = false;
          environment.systemPackages = fontPackages pkgs;
        };

      homeManager =
        { pkgs, ... }:
        {
          stylix = stylixFonts pkgs;
          home.packages = fontPackages pkgs;
        };
    };
}

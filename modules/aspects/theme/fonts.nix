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
            sizes.terminal = 14;
          };
          targets = {
            font-packages.enable = true;
            fontconfig.enable = true;
          };
        };
    in
    {
      nixos =
        { pkgs, ... }:
        {
          stylix = stylixFonts pkgs;
          fonts.enableDefaultPackages = true;
        };

      homeManager =
        { pkgs, ... }:
        {
          stylix = stylixFonts pkgs;
        };
    };
}

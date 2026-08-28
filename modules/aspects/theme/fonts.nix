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
          fonts.enableDefaultPackages = false;
          environment.systemPackages = [
            pkgs.nerd-fonts.symbols-only
            pkgs.noto-fonts-color-emoji
          ];
        };

      #   homeManager =
      #     { pkgs, ... }:
      #     {
      #       stylix = stylixFonts pkgs;
      #       home.packages = [
      #         pkgs.nerd-fonts.symbols-only
      #         pkgs.noto-fonts-color-emoji
      #       ];
      #     };
      # };
    };
}

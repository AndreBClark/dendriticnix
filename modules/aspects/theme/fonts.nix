{
  den.aspects.theme.fonts = {
    nixos =
      { pkgs, ... }:
      {
        fonts = {
          enableDefaultPackages = true;
          fontconfig = {
            defaultFonts = {
              monospace = [
                "JetBrainsMono Nerd Font"
              ];
              emoji = [
                "Noto Color Emoji"
              ];
            };
          };
          packages = builtins.attrValues {
            inherit (pkgs.nerd-fonts)
              jetbrains-mono
              fira-code
              ;
            inherit (pkgs)
              noto-fonts-color-emoji
              ;
          };
        };
      };

    homeManager =
      { pkgs, config, ... }:
      {
        stylix = {
          fonts = {
            monospace = {
              package = pkgs.nerd-fonts.jetbrains-mono;
              name = "JetBrainsMono Nerd Font Mono";
            };

            emoji = {
              package = pkgs.noto-fonts-color-emoji;
              name = "Noto Color Emoji";
            };
            serif = config.stylix.fonts.monospace;
            sansSerif = config.stylix.fonts.monospace;
          };
          targets = {
            font-packages.enable = true;
            fontconfig.enable = true;
          };
        };
      };
  };
}

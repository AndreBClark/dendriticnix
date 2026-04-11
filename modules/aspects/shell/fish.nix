{ den, ... }:
{
  den.aspects.shell.fish = {
    includes = [
      (den.provides.user-shell "fish")
      den.aspects.prompts.starship
    ];
    nixos =
      { pkgs, ... }:
      {
        programs.fish = {
          enable = true;

          promptInit = ''
            ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
          '';
        };
        documentation.man.cache.enable = false;
      };
    homeManager =
      { pkgs, ... }:
      let
        sources = import ../../npins;
      in
      {
        programs = {
          fish = {
            enable = true;
            plugins = [
              {
                inherit (pkgs.fishPlugins.autopair) src name;
              }
              {
                inherit (pkgs.fishPlugins.done) src name;
              }
              {
                inherit (pkgs.fishPlugins.sponge) src name;
              }
              {
                inherit (pkgs.fishPlugins.grc) src name;
              }
              {
                inherit (pkgs.fishPlugins.fifc) src name;
              }
              {
                name = "getopts";
                src = sources.getopts;
              }
              {
                name = "colored_man_pages";
                src = sources.colored_man_pages_fish;
              }
              {
                name = "fish-abbreviation-tips";
                src = sources.fish-abbreviation-tips;
              }
            ];
            interactiveShellInit = ''
              set --export fish_greeting

              ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
            '';
            shellAliases = {
              ls = "eza";
              ll = "eza -l";
              la = "eza -A";
              lt = "eza -T";
              cd = "z";
              vim = "nvim";
            };
          };
          man.generateCaches = false;
          kitty.shellIntegration.enableFishIntegration = true;
          starship.enableFishIntegration = true;
          zoxide.enableFishIntegration = true;
          fzf.enableFishIntegration = true;
          lazygit.enableFishIntegration = true;
          yazi.enableFishIntegration = true;
          eza.enableFishIntegration = true;
          direnv.enableFishIntegration = true;
          tmux.shell = "${pkgs.fish}/bin/fish";
        };
        home.packages = [
          pkgs.grc
          pkgs.jq
        ];
      };
  };
}

{ den, lib, ... }:
{
  den.aspects.shell.fish = {
    includes = [
      (den.provides.user-shell "fish")
      den.aspects.shell.starship
      (den.batteries.shell-integrations [
        "direnv"
        "devenv"
        "eza"
        "fzf"
        "lazygit"
        "starship"
        "yazi"
        "zoxide"
      ])
    ];
    nixos =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.nix-your-shell ];
        programs.fish = {
          enable = true;
          useBabelfish = true;
          shellInit = ''
            nix-your-shell fish | source
          '';
          vendor.completions.enable = true;
        };
      };
    homeManager =
      { pkgs, config, ... }:
      let
        mkFishPlugin = plugin: { inherit (plugin) src name; };

        mkFishPlugins = names: map (name: mkFishPlugin pkgs.fishPlugins.${name}) names;

        pluginNames = [
          "autopair"
          "done"
          "sponge"
          "grc"
          "bang-bang"
          "colored-man-pages"
          "git-abbr"
        ];
      in
      {
        home = {
          shell.enableFishIntegration = lib.mkDefault true;

          packages = [
            pkgs.grc
            pkgs.jq
          ];

        };

        programs = {
          fish = {
            enable = true;
            plugins = mkFishPlugins pluginNames;
            shellAbbrs = config.home.shellAliases;
            interactiveShellInit = ''
              set --export fish_greeting
            '';

            binds = {
              "alt-g" = {
                command = "cd $HOME";
                repaint = true;
              };
            };
          };

          nix-your-shell = {
            enable = true;
            enableFishIntegration = lib.mkDefault true;
          };

          kitty.shellIntegration.enableFishIntegration = lib.mkDefault true;

          tmux.shell = "${pkgs.fish}/bin/fish";
        };

      };
  };
}

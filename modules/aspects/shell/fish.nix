{ den, lib, ... }:
{
  den.aspects.shell.fish = {
    includes = [
      (den.provides.user-shell "fish")
      den.aspects.shell.starship
      (den.batteries.shell-integrations [
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

          vendor.completions.enable = true;
        };
      };
    homeManager =
      { pkgs, ... }:
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

          packages = builtins.attrValues {
            inherit (pkgs)
              grc
              jq
              fastfetch
              ;
          };

        };

        programs = {
          fish = {
            enable = true;
            generateCompletions = true;
            interactiveShellInit = ''
              set -g fish_prompt_pwd_dir_length 0
              set -g fish_prompt_pwd_full_dirs 0
            '';
            plugins = mkFishPlugins pluginNames;
            binds = {
              "alt-g" = {
                command = "cd $HOME";
                repaint = true;
              };
            };
            functions = {
              fish_greeting = {
                body = ''
                  status is-interactive; or return
                  set -q DEVENV_PROFILE; and return
                  set -q IN_NIX_SHELL; and return
                  test "$SHLVL" -le 2; or return
                  fastfetch
                '';
              };
              nsh = {
                body = "nix-shell -p $argv";
                wraps = "nix-shell";
              };
              nsr = {
                body = ''
                  nix-shell -p $argv[1] --run (string join " " -- $argv[2..-1])
                '';
                wraps = "nix-shell";
              };
              codecontext = {
                body = ''
                  code2prompt $argv --no-codeblock --token-map --hidden -O - | string trim -r | head -c 49000 | fish_clipboard_copy
                '';
                wraps = "code2prompt";
                description = "copy code files, truncated to 49k bytes";
              };
            };
          };
          man.generateCaches = false;
          nix-your-shell = {
            enable = true;
            enableFishIntegration = lib.mkDefault true;

          };

          kitty.shellIntegration = {
            enableFishIntegration = lib.mkDefault true;
            mode = "no-cursor";
          };
        };

      };
  };
}

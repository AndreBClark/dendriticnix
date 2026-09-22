{ den, lib, ... }:
{
  den.aspects.shell.fish =
    let
      shellInit = ''
        set fish_prompt_pwd_dir_length 0
        set fish_prompt_pwd_full_dirs 3
        set fish_prompt_pwd_use_path true
        functions -e __fish_prompt_pwd
        functions -e fish_prompt
      '';
    in
    {
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
              ${shellInit}
            '';

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
              plugins = mkFishPlugins pluginNames;
              inherit shellInit;
              binds = {
                "alt-g" = {
                  command = "cd $HOME";
                  repaint = true;
                };
              };
              functions = {
                fish_greeting = ''
                  fastfetch
                '';
                codecontext = {
                  body = ''
                    code2prompt $argv --no-codeblock --token-map --hidden | fish_clipboard_copy
                  '';
                  description = "copy code files";
                };
              };

            };
            man.generateCaches = false;
            nix-your-shell = {
              enable = true;
              enableFishIntegration = lib.mkDefault true;

            };

            kitty.shellIntegration.enableFishIntegration = lib.mkDefault true;

          };

        };
    };
}

{ lib, ... }:
let
  description = ''
    Enables shell integration for a list of Home Manager program modules.

    Usage:

      den.aspects.tux.includes = [
        (den.batteries.shell-integrations [
          "starship" "zoxide" "fzf" "lazygit" "yazi" "eza" "direnv" "devenv"
        ])
      ];
  '';

  shellIntegrations = shell: modules: {
    homeManager = lib.foldl' lib.recursiveUpdate { } (
      map (module: {
        programs.${module}."enable${lib.strings.toSentenceCase shell}Integration" = lib.mkOverride 75 true;
      }) modules
    );
  };
in
{
  den.batteries.shell-integrations = modules: {
    inherit description;
    includes = [
      ({ user, ... }: shellIntegrations user.shell modules)
    ];
  };
}

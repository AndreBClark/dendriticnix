{ pkgs, ... }:
{
  name = "Nix";
  # Nix development tools and the Nix language server.
  languages = {
    nix = {
      enable = true;
      lsp.package = pkgs.nil;
    };
  };

  # Command-line tools available in the project environment.
  packages = [
    pkgs.nh
    pkgs.npins
    pkgs.nurl
    pkgs.nil
    pkgs.treefmt
    pkgs.statix
    pkgs.deadnix
  ];

  # Keep direnv quiet and load this environment automatically from the project.
  env = {
    DIRENV_LOG_FORMAT = "";
  };

  files.".envrc".text = ''
    eval "$(devenv direnvrc --quiet)"
    use devenv
  '';

  # Format and lint changed files automatically through pre-commit hooks.
  git-hooks = {
    enable = true;
    hooks = {
      treefmt = {
        enable = true;
        excludes = [ "npins/*" ];
      };
      statix = {
        enable = true;
        settings.ignore = [ "npins/*" ];
        excludes = [ "npins/*" ];
      };
      deadnix = {
        enable = true;
        excludes = [ "npins/*" ];
      };
    };
  };

  # treefmt also ignores the generated npins expression when run directly.
  treefmt = {
    enable = true;
    config = {
      programs.nixfmt.enable = true;
      settings.global.excludes = [ "npins/*" ];
    };
  };

  # See full reference at https://devenv.sh/reference/options/
}

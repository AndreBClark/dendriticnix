{ pkgs, ... }:

{

  packages = builtins.attrValues {
    inherit (pkgs)
      nh
      npins
      nurl
      jq;
  };

  languages.nix.enable = true;
  git-hooks.package = pkgs.prek;
  git-hooks.hooks = {
    nixpkgs-fmt.enable = true;
    rustfmt.enable = true;
  };
  enterShell = ''
    export NIXPKGS_ALLOW_UNFREE=1
  '';
}

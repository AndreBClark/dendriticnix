{ den, ... }:
{
  den.aspects.cli = {
    includes = builtins.attrValues {
      inherit (den.aspects.cli)
        bat
        devenv
        fd
        eza
        fzf
        git
        lazygit
        nh
        zoxide
        ;
    };

    homeManager =
      { pkgs, ... }:
      {
        home = {
          packages = builtins.attrValues {
            inherit (pkgs)
              code2prompt
              ghgrab
              ripgrep
              ;
          };
        };
      };
  };
}

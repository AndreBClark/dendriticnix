{
  den,
  lib,
  ...
}:
{
  den = {
    aspects.nvim = {
      includes = builtins.attrValues {
        inherit (den.aspects.nvim)
          lsp
          keymaps
          options
          plugins
          highlight
          ;
      };

      nixvim = {
        viAlias = true;
        vimAlias = true;

        highlightOverride =
          let
            transparentBackground = {
              main = true;
              signColumn = false;
              numberLine = false;
            };
            transparent = {
              bg = "none";
              ctermbg = "none";
            };
          in
          {
            Normal = lib.mkIf transparentBackground.main transparent;
            NonText = lib.mkIf transparentBackground.main transparent;
            SignColumn = lib.mkIf transparentBackground.signColumn transparent;
            LineNr = lib.mkIf transparentBackground.numberLine transparent;
            LineNrAbove = lib.mkIf transparentBackground.numberLine transparent;
            LineNrBelow = lib.mkIf transparentBackground.numberLine transparent;
          };
      };

      homeManager =
        {
          user,
          pkgs,
          config,
          ...
        }:
        {
          imports = [
            { programs.nixvim = den.lib.nixvim.module den.aspects.nvim; }
            { programs.nixvim = den.lib.nixvim.mkColorscheme { inherit user pkgs lib; }; }
          ];

          programs.nixvim = {
            enable = true;
            defaultEditor = true;
          };

          stylix.targets.nixvim = {
            plugin = "base16-nvim";
            transparentBackground.main = true;
          };

          home.shellAliases = {
            v = "nvim";
            nvpurge = "rm -rf ${config.home.homeDirectory}/.local/state/nvim/swap";
          };
        };
    };
    aspects.my.packages =
      { pkgs, ... }:
      let
        system = pkgs.stdenv.hostPlatform.system;
        pkgsUnfree = import pkgs.path {
          inherit system;
          config.allowUnfree = true;
        };
        user = den.hosts.${system}.seadragon.users.andrec;
      in
      {
        nixvim = den.lib.nixvim.package pkgsUnfree den.aspects.nvim [
          (den.lib.nixvim.mkColorscheme {
            inherit user;
            pkgs = pkgsUnfree;
            inherit lib;
          })
        ];
      };
  };
}

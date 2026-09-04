{ inputs, den, ... }:
{
  flake-file.inputs = {
    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };
  den.aspects.nvim = {
    includes = builtins.attrValues {
      inherit (den.aspects.nvim)
        lsp
        keymaps
        options
        plugins
        highlight
        ;
    };

    homeManager =
      { config, ... }:
      {
        imports = [
          inputs.nixvim.homeModules.nixvim
        ];
        programs.nixvim = {
          enable = true;
          defaultEditor = true;
          nixpkgs.useGlobalPackages = true;
        };

        stylix.targets.nixvim = {
          plugin = "base16-nvim";
          transparentBackground = {
            main = true;
            numberLine = true;
            signColumn = true;
          };
        };

        home.shellAliases = {
          v = "nvim";
          vi = "nvim";
          vim = "nvim";
          nvpurge = "rm -rf ${config.home.homeDirectory}/.local/state/nvim/swap";
        };
      };
  };
}

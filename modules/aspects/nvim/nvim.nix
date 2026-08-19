{ inputs, den, ... }:
{
  flake-file.inputs = {
    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };
  den.aspects.nvim = {
    includes = [
      den.aspects.nvim.provides.lsp
      den.aspects.nvim.provides.keymaps
      den.aspects.nvim.provides.options
      den.aspects.nvim.provides.plugins
    ];
    homeManager =
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
        };
      };
  };
}

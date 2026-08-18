{ inputs, ... }:
{
  flake-file.inputs = {
    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };
  den.aspects.nvim = {
    homeManager =
      { lib, config, ... }:
      let
        stylixEnabled = config.stylix.enable or false;
      in
      {
        imports = [
          inputs.nixvim.homeModules.nixvim
        ];
        programs.nixvim = {
          enable = true;
          defaultEditor = true;
          nixpkgs.useGlobalPackages = true;
          userCommands = {
            W.command = "w";
            Q.command = "q";
          };
          colorschemes.base16 = {
            enable = !stylixEnabled;
            colorscheme = lib.mkDefault config.lib.stylix.colors.scheme or "tokyo-night-moon";
            settings.lualine_bold = true;
          };
          dependencies = {
            ripgrep.enable = true;
          };
        };
      };
  };
}

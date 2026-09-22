{
  den,
  lib,
  inputs,
  ...
}:
{
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim";

  den.aspects.nvim =
    let
      mkColorscheme =
        {
          user,
          pkgs,
          lib,
        }:
        let
          colorscheme = den.lib.theme.palette { inherit pkgs lib user; };
        in
        {
          base16 = {
            enable = true;
            inherit colorscheme;
          };
        };

      nixvimConfig = {
        viAlias = true;
        vimAlias = true;
        dependencies.ripgrep.enable = true;
        imports = [ (inputs.import-tree ./_config) ];
      };
    in
    {
      homeManager =
        {
          user,
          pkgs,
          config,
          ...
        }:
        {
          imports = [ inputs.nixvim.homeModules.nixvim ];

          programs.nixvim = nixvimConfig // {
            enable = true;
            defaultEditor = true;
            colorschemes = mkColorscheme { inherit user pkgs lib; };
            nixpkgs.config.allowUnfree = true;
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
      packages =
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
          nixvim =
            (inputs.nixvim.lib.evalNixvim {
              modules = [
                (
                  nixvimConfig
                  // {
                    performance = {
                      byteCompileLua = {
                        enable = true;
                        nvimRuntime = true;
                        luaLib = true;
                        initLua = true;
                        plugins = true;
                        excludedPlugins = [
                          "nvim-treesitter"
                        ];
                      };

                      combinedPlugins = {
                        enable = true;
                        standalonePlugins = [ "nvim-treesitter" ];
                      };
                    };
                    colorschemes = mkColorscheme {
                      inherit user lib;
                      pkgs = pkgsUnfree;
                    };
                  }
                )
                { nixpkgs.pkgs = pkgsUnfree; }
              ];
            }).config.build.package.overrideAttrs
              (_: {
                pname = "nixvim";
              });
        };
    };
}

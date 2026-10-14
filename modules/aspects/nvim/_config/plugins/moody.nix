{ pkgs, config, ... }:
let
  colors = config.colorschemes.base16.colorscheme;
in
{
  extraPlugins =
    let
      sources = import ../../../../../npins;
      # TODO: lower brightness of base blend amount
      moodyConfig =
        with colors;
        # lua
        ''
          local blend = { dark = 0.5, bright = 0.8, base = 0.75 }
          require("moody").setup({
            blends = {
              insert = blend.dark,
              visual = blend.bright,
              normal = blend.base,
              command = blend.bright,
              operator = blend.bright,
              replace = blend.dark,
              select = blend.bright,
            },

            colors = {
              normal = "${base0D}",
              insert = "${base0B}",
              visual = "${base0E}",
              command = "${base0C}",
              operator = "${base0C}",
              replace = "${base09}",
              select = "${base0E}",
              terminal = "${base0C}",
              terminal_n = "${base0D}"
            },
            bold_line_number = true,


            recording = { enabled = true },
            column = { enabled = false }
          })
        '';
    in
    [
      (pkgs.vimUtils.buildVimPlugin {
        name = "moody.nvim";
        src = sources.moody-nvim;
        nvimSkipModules = [ "moody.statuscolumn" ];
        postInstall = ''
          substituteInPlace $out/lua/moody/utils.lua --replace-fail \
          'name = "Normal"' 'name = "CursorLine"'
          substituteInPlace $out/lua/moody/config.lua --replace-fail \
            '["r"] = "ns_replace",' \
            '["r"] = "ns_replace", ["R"] = "ns_replace", ["Rv"] = "ns_replace", ["Rc"] = "ns_replace", ["Rx"] = "ns_replace",'
          rm $out/plugin/moody.vim
          cat > $out/plugin/moody.lua <<'EOF'
          ${moodyConfig}
          EOF
        '';
      })
    ];
}

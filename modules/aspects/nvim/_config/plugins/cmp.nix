{
  plugins = {
    cmp-nvim-lsp-signature-help.enable = true;
    cmp = {
      enable = true;
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "nvim_lsp_signature_help"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "luasnip"; }
        { name = "treesitter"; }
        { name = "yanky"; }
        { name = "fish"; }
      ];
      settings.mapping = {
        "<Tab>" = "cmp.mapping.select_next_item()";
        "<S-Tab>" = "cmp.mapping.select_prev_item()";
        "<C-j>" = "cmp.mapping.scroll_docs(4)";
        "<C-k>" = "cmp.mapping.scroll_docs(-4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-Esc>" = "cmp.mapping.close()";
        "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
        "<Up>" = "cmp.mapping.select_prev_item()";
        "<Down>" = "cmp.mapping.select_next_item()";
        "<Left>" = "cmp.mapping.close()";
        "<Right>" = "cmp.mapping.confirm({ select = true })";
      };
    };
  };
}

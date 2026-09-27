{
  plugins.noice = {
    enable = true;
    settings = {
      cmdline = {
        enabled = true;
        view = "cmdline_popup";
      };

      messages = {
        enabled = true;
        view = "mini";
      };

      popupmenu.enabled = false;

      lsp = {
        progress = {
          enabled = true;
          view = "mini";
        };
        hover.enabled = true;
      };

      notify = {
        enabled = false;
        view = "notify";
      };

      lsp.override = {
        "vim.lsp.util.convert_input_to_markdown_lines" = true;
        "vim.lsp.util.stylize_markdown" = true;
      };
      presets = {
        bottom_search = false; # keep search in cmdline popup
        command_palette = true; # cmdline + popupmenu together
        long_message_to_split = true; # long msgs go to split, not scroll
        lsp_doc_border = true; # rounded hover/signature borders
      };
    };
  };
}

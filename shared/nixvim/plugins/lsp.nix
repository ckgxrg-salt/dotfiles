{ ... }:
# Plugins utilising LSP
{
  programs.nixvim.plugins = {
    # Diagnostics list
    trouble = {
      enable = true;
      settings = {
        auto_close = false;
        open_no_results = true;
      };
    };

    # Generate statusline content from LSP
    lsp-status = {
      enable = true;
      settings = {
        component_separator = " | ";
        current_function = true;
        show_filename = true;
        diagnostics = false;
      };
    };

    # Get hint from LSP
    lsp-signature = {
      enable = true;
    };

    # Show diagnostics from LSP
    lsp-lines = {
      enable = true;
    };

    # Add icons
    lspkind = {
      enable = true;
      mode = "symbol_text";
      preset = "codicons";
      cmp = {
        enable = true;
      };
    };
  };
}

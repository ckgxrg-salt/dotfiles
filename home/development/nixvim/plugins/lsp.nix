{ config, lib, ... }:
# Plugins utilising LSP
{
  config = lib.mkIf config.development.neovim.enable {
    programs.nixvim = {
      plugins = {
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

        # Enhance LSP experience
        lspsaga = {
          enable = true;
          lightbulb.enable = false;
        };
      };
      keymaps = [
        {
          mode = "n";
          key = "K";
          action = ":Lspsaga hover_doc<CR>";
          options.desc = "Check Hover Doc";
        }
        {
          mode = "n";
          key = "<Leader>lo";
          action = ":Lspsaga outline<CR>";
          options.desc = "Display Outline";
        }
        {
          mode = "n";
          key = "<Leader>lr";
          action = ":Lspsaga rename<CR>";
          options.desc = "Rename Selected";
        }
        {
          mode = "n";
          key = "<Leader>la";
          action = ":Lspsaga code_action<CR>";
          options.desc = "Display Actions for Selected";
        }
      ];
    };
  };
}

{ config, lib, ... }:
# Plugins that assist coding
{
  config = lib.mkIf config.development.neovim.enable {
    programs.nixvim = {
      plugins = {
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

        # Working with Nix
        nix = {
          enable = true;
        };
        nix-develop = {
          enable = true;
        };

        # Markdown preview
        markdown-preview = {
          enable = true;
          settings = {
            browser = "firefox";
            theme = "dark";
          };
        };

        # Deduce indentation width
        guess-indent = {
          enable = true;
          settings = {
            auto_cmd = true;
          };
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

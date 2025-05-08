{ ... }:
# Plugins that enhances nvim's UI
{
  programs.nixvim = {
    plugins = {
      # File explorer
      yazi = {
        enable = true;
        settings = {
          enable_mouse_support = true;
          yazi_floating_window_border = "solid";
          yazi_floating_window_winblend = 25;
        };
      };

      # Startup page
      alpha = {
        enable = true;
        theme = "dashboard";
      };

      # Splits
      smart-splits = {
        enable = true;
        settings = {
          at_edge = "stop";
        };
      };

      # Terminal
      toggleterm = {
        enable = true;
        settings = {
          close_on_exit = true;
          direction = "horizontal";
          shell = "nu";
        };
      };

      # Enhanced UI
      nui = {
        enable = true;
      };
      noice = {
        enable = true;
        settings = {
          presets = {
            command_palette = true;
          };
          messages = {
            enabled = false;
          };
          lsp = {
            hover = {
              silent = true;
            };
          };
        };
      };

      # Indent lines
      indent-blankline = {
        enable = true;
        settings = {
          exclude = {
            buftypes = [
              "terminal"
              "nofile"
              "quickfix"
              "prompt"
            ];
            filetypes = [
              "lspinfo"
              "packer"
              "checkhealth"
              "help"
              "man"
              "gitcommit"
              "TelescopePrompt"
              "TelescopeResults"
              "dashboard"
              "''"
            ];
          };
          scope = {
            enabled = true;
            injected_languages = true;
            show_exact_scope = true;
            show_start = true;
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<Leader>cf";
        action = ":Yazi<CR>";
        options.desc = "Browse Files";
      }
      {
        mode = "n";
        key = "<Leader>cu";
        action = ":UndotreeToggle<CR>";
        options.desc = "Toggle Undo Tree";
      }
    ];
  };
}

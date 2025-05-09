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
      {
        mode = "n";
        key = "<A-h>";
        action = "require('smart-splits').resize_left";
        options.desc = "Resize the Current Split to the Left";
      }
      {
        mode = "n";
        key = "<A-j>";
        action = "require('smart-splits').resize_down";
        options.desc = "Resize the Current Split to the Bottom";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "require('smart-splits').resize_up";
        options.desc = "Resize the Current Split to the Top";
      }
      {
        mode = "n";
        key = "<A-l>";
        action = "require('smart-splits').resize_right";
        options.desc = "Resize the Current Split to the Right";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "require('smart-splits').move_cursor_left";
        options.desc = "Move to the Split Left";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "require('smart-splits').move_cursor_down";
        options.desc = "Move to the Split Beneath";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "require('smart-splits').move_cursor_up";
        options.desc = "Move to the Split Above";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "require('smart-splits').move_cursor_right";
        options.desc = "Move to the Split Right";
      }
      {
        mode = "n";
        key = "<C-H>";
        action = "require('smart-splits').swap_buf_left";
        options.desc = "Swap with the Split Left";
      }
      {
        mode = "n";
        key = "<C-J>";
        action = "require('smart-splits').swap_buf_down";
        options.desc = "Swap with the Split Beneath";
      }
      {
        mode = "n";
        key = "<C-K>";
        action = "require('smart-splits').swap_buf_up";
        options.desc = "Swap with the Split Above";
      }
      {
        mode = "n";
        key = "<C-L>";
        action = "require('smart-splits').swap_buf_right";
        options.desc = "Swap with the Split Right";
      }
    ];
  };
}

{ config, lib, ... }:
# Plugins that enhances nvim's UI
{
  config = lib.mkIf config.development.neovim.enable {
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
          key = "<A-Tab>";
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
          action = ":lua require('smart-splits').resize_left<CR>";
          options.desc = "Resize the Current Split to the Left";
        }
        {
          mode = "n";
          key = "<A-j>";
          action = ":lua require('smart-splits').resize_down<CR>";
          options.desc = "Resize the Current Split to the Bottom";
        }
        {
          mode = "n";
          key = "<A-k>";
          action = ":lua require('smart-splits').resize_up<CR>";
          options.desc = "Resize the Current Split to the Top";
        }
        {
          mode = "n";
          key = "<A-l>";
          action = ":lua require('smart-splits').resize_right<CR>";
          options.desc = "Resize the Current Split to the Right";
        }
        {
          mode = "n";
          key = "<Leader>mh";
          action = ":lua require('smart-splits').move_cursor_left<CR>";
          options.desc = "Move to the Split Left";
        }
        {
          mode = "n";
          key = "<Leader>mj";
          action = ":lua require('smart-splits').move_cursor_down<CR>";
          options.desc = "Move to the Split Down";
        }
        {
          mode = "n";
          key = "<Leader>mk";
          action = ":lua require('smart-splits').move_cursor_up<CR>";
          options.desc = "Move to the Split Up";
        }
        {
          mode = "n";
          key = "<Leader>ml";
          action = ":lua require('smart-splits').move_cursor_right<CR>";
          options.desc = "Move to the Split Right";
        }
        {
          mode = "n";
          key = "<Leader>mH";
          action = ":lua require('smart-splits').swap_buf_left<CR>";
          options.desc = "Swap with the Split Left";
        }
        {
          mode = "n";
          key = "<Leader>mJ";
          action = ":lua require('smart-splits').swap_buf_down<CR>";
          options.desc = "Swap with the Split Down";
        }
        {
          mode = "n";
          key = "<Leader>mK";
          action = ":lua require('smart-splits').swap_buf_up<CR>";
          options.desc = "Swap with the Split Up";
        }
        {
          mode = "n";
          key = "<Leader>mL";
          action = ":lua require('smart-splits').swap_buf_right<CR>";
          options.desc = "Swap with the Split Right";
        }
      ];
    };
  };
}

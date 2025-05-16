{ config, lib, ... }:
# Plugins related to the lines
{
  config = lib.mkIf config.development.neovim.enable {
    programs.nixvim = {
      plugins = {
        # Tabline
        bufferline = {
          enable = true;
          settings = {
            options = {
              diagnostics = "nvim_lsp";
              diagnostics_indicator.__raw = ''
                function(count, level, diagnostics_dict, context)
                  local s = " "
                  for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and " "
                      or (e == "warning" and " " or " ")
                    s = s .. n .. sym
                  end
                  return s
                end
              '';
              separator_style = "slant";
              indicator.style = "underline";
              right_mouse_command = null;
            };
          };
        };

        # Statusline
        lualine = {
          enable = true;
          settings = {
            options = {
              globalstatus = true;
            };
          };
        };

        # Cursorline
        illuminate = {
          enable = true;
          underCursor = true;
          providers = [
            "lsp"
            "treesitter"
            "regex"
          ];
        };
      };
      keymaps = [
        {
          mode = "n";
          key = "<C-h>";
          action = ":BufferLineCyclePrev<CR>";
          options.desc = "Switch to Previous Tab";
        }
        {
          mode = "n";
          key = "<C-l>";
          action = ":BufferLineCycleNext<CR>";
          options.desc = "Switch to Next Tab";
        }
        {
          mode = "n";
          key = "<C-1>";
          action = ":BufferLineGoToBuffer 1<CR>";
          options.desc = "Switch to Tab 1";
        }
        {
          mode = "n";
          key = "<C-2>";
          action = ":BufferLineGoToBuffer 2<CR>";
          options.desc = "Switch to Tab 2";
        }
        {
          mode = "n";
          key = "<C-3>";
          action = ":BufferLineGoToBuffer 3<CR>";
          options.desc = "Switch to Tab 3";
        }
        {
          mode = "n";
          key = "<C-4>";
          action = ":BufferLineGoToBuffer 4<CR>";
          options.desc = "Switch to Tab 4";
        }
        {
          mode = "n";
          key = "<C-5>";
          action = ":BufferLineGoToBuffer 5<CR>";
          options.desc = "Switch to Tab 5";
        }
        {
          mode = "n";
          key = "<C-S-h>";
          action = ":BufferLineMovePrev<CR>";
          options.desc = "Move Current Tab to the Left";
        }
        {
          mode = "n";
          key = "<C-S-l>";
          action = ":BufferLineMoveNext<CR>";
          options.desc = "Move Current Tab to the Right";
        }
      ];
    };
  };
}

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
          key = "<Leader>mh";
          action = ":BufferLineCyclePrev<CR>";
          options.desc = "Switch to Previous Tab";
        }
        {
          mode = "n";
          key = "<Leader>ml";
          action = ":BufferLineCycleNext<CR>";
          options.desc = "Switch to Next Tab";
        }
        {
          mode = "n";
          key = "<Leader>mH";
          action = ":BufferLineMovePrev<CR>";
          options.desc = "Move Current Tab to the Left";
        }
        {
          mode = "n";
          key = "<Leader>mL";
          action = ":BufferLineMoveNext<CR>";
          options.desc = "Move Current Tab to the Right";
        }
        {
          mode = "n";
          key = "<C-w>";
          action = ":bdelete<CR>";
          options = {
            nowait = true;
            desc = "Close Current Tab";
          };
        }
      ];
    };
  };
}

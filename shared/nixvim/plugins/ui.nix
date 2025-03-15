{ ... }:
# Plugins that enhances nvim's UI
{
  programs.nixvim.plugins = {
    # File explorer
    yazi = {
      enable = true;
      settings = {
        enable_mouse_support = true;
        yazi_floating_window_border = "solid";
        yazi_floating_window_winblend = 25;
      };
    };

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
}

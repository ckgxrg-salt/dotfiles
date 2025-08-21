{
  plugins = {
    yazi = {
      enable = true;
      settings = {
        enable_mouse_support = true;
        open_for_directories = true;
        yazi_floating_window_border = "solid";
        yazi_floating_window_winblend = 25;
      };
    };

    fidget = {
      enable = true;
      settings = {
        progress.display = {
          render_limit = 10;
          done_ttl = 5;
        };
        notification.window.winblend = 0;
      };
    };

    edgy = {
      enable = true;
      settings = {
        close_when_all_hidden = false;
        keys = {
          "q" = false;
        };
        options = {
          right.size.__raw = "0.3";
        };
        bottom = [
          {
            ft = "dap-view";
            title = "Debug";
          }
          {
            ft = "trouble";
            title = "Trouble";
          }
        ];
        left = [
          {
            ft = "undotree";
            title = "Undo tree";
          }
          {
            ft = "aerial";
            title = "Outline";
          }
          {
            ft = "neotest-summary";
            title = "Tests summary";
          }
        ];
        right = [
          {
            ft = "codecompanion";
            title = "CodeCompanion";
          }
          {
            ft = "help";
            title = "Help";
          }
        ];
      };
    };

    hlchunk = {
      enable = true;
      settings = {
        chunk = {
          enable = true;
          chars = {
            horizontal_line = "─";
            vertical_line = "│";
            left_top = "┌";
            left_bottom = "└";
            right_arrow = "─";
          };
        };
        indent = {
          enable = true;
        };
        line_num = {
          enable = true;
        };
      };
    };

    trouble = {
      enable = true;
      settings = {
        warn_no_results = false;
        open_no_results = true;
      };
    };

    codecompanion = {
      enable = true;
      settings = {
        adapters = {
          "gemini".__raw = ''
            function()
              return require("codecompanion.adapters").extend("gemini", {
                env = {
                  api_key = "cmd:cat $HOME/.config/sops-nix/secrets/gemini-token",
                },
              })
            end
          '';
        };
        strategies = {
          chat.adapter = "gemini";
        };
      };
    };

    inc-rename.enable = true;

    aerial = {
      enable = true;
      settings = {
        backends = [
          "lsp"
          "treesitter"
          "markdown"
        ];
        highlight_on_hover = true;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>eo";
      action = ":AerialToggle<CR>";
      options.desc = "Display outline";
    }
    {
      mode = "n";
      key = "<leader>cr";
      action = ":IncRename ";
      options.desc = "Rename selected";
    }

    {
      mode = "n";
      key = "<leader>cd";
      action = ":Trouble diagnostics toggle<CR>";
      options.desc = "Show diagnostics";
    }
    {
      mode = "n";
      key = "<leader>cq";
      action = ":Trouble quickfix toggle<CR>";
      options.desc = "Show quickfix";
    }
    {
      mode = "n";
      key = "<leader>cf";
      action = ":Trouble lsp_definitions toggle<CR>";
      options.desc = "Show definitions";
    }
    {
      mode = "n";
      key = "<leader>ce";
      action = ":Trouble lsp_references toggle<CR>";
      options.desc = "Show references";
    }

    {
      mode = "n";
      key = "<A-Tab>";
      action = ":Yazi<CR>";
      options.desc = "Browse files";
    }
    {
      mode = "n";
      key = "<leader>ea";
      action = ":CodeCompanionChat Toggle<CR>";
      options.desc = "Toggle CodeCompanion";
    }
  ];
}

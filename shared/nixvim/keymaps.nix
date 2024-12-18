{ ... }:
{
  # For coding time, start with Meta
  # For "running", including Markdown preview, start with Ctrl
  programs.nixvim = {
    keymaps = [
      # Neovim: Generals
      {
        action = "gj";
        key = "j";
        options = {
          silent = true;
        };
      }
      {
        action = "gk";
        key = "k";
        options = {
          silent = true;
        };
      }
      {
        action = "gj";
        key = "<Down>";
        options = {
          silent = true;
        };
      }
      {
        action = "gk";
        key = "<Up>";
        options = {
          silent = true;
        };
      }

      # Dap & Dap-UI: Enter debugging mode
      {
        action = "<Cmd>lua require('dapui').toggle()<CR>";
        key = "<M-d>";
        mode = "n";
      }

      # Glow: Preview Markdown
      {
        action = "<Cmd>Glow<CR>";
        key = "<M-r>";
        mode = "n";
      }

      # Neotree: Summon
      {
        action = "<Cmd>Neotree toggle<CR><Cmd>cd .<CR>";
        key = "<M-b>";
      }

      # Undotree: Summon
      {
        action = "<Cmd>UndotreeToggle<CR>";
        key = "<M-u>";
      }

      # Trouble: Summon
      {
        action = "<Cmd>Trouble diagnostics toggle<CR>";
        key = "<M-o>";
      }
      {
        action = "<Cmd>Trouble lsp toggle<CR>";
        key = "<M-s>";
      }

      # Hover: Summon
      {
        action = "<Cmd>lua require('hover').hover()<CR>";
        key = "K";
        mode = "n";
        options.desc = "hover.nvim";
      }
      {
        action = "<Cmd>lua require('hover').hover_switch('previous')<CR>";
        key = "<C-p>";
        mode = "n";
        options.desc = "hover.nvim (Previous Source)";
      }
      {
        action = "<Cmd>lua require('hover').hover_switch('next')<CR>";
        key = "<C-n>";
        mode = "n";
        options.desc = "hover.nvim (Next Source)";
      }

      # Barbar: Navigate between tabs
      {
        action = "<Cmd>BufferPrevious<CR>";
        key = "<M-k>";
      }
      {
        action = "<Cmd>BufferNext<CR>";
        key = "<M-j>";
      }
      {
        action = "<Cmd>BufferMovePrevious<CR>";
        key = "<M-K>";
      }
      {
        action = "<Cmd>BufferMoveNext<CR>";
        key = "<M-J>";
      }
      {
        action = "<Cmd>BufferGoto 1<CR>";
        key = "<M-1>";
      }
      {
        action = "<Cmd>BufferGoto 2<CR>";
        key = "<M-2>";
      }
      {
        action = "<Cmd>BufferGoto 3<CR>";
        key = "<M-3>";
      }
      {
        action = "<Cmd>BufferGoto 4<CR>";
        key = "<M-4>";
      }
      {
        action = "<Cmd>BufferGoto 5<CR>";
        key = "<M-5>";
      }
      {
        action = "<Cmd>BufferGoto 6<CR>";
        key = "<M-6>";
      }
      {
        action = "<Cmd>BufferGoto 7<CR>";
        key = "<M-7>";
      }
      {
        action = "<Cmd>BufferGoto 8<CR>";
        key = "<M-8>";
      }
      {
        action = "<Cmd>BufferGoto 9<CR>";
        key = "<M-9>";
      }
      {
        action = "<Cmd>BufferLast<CR>";
        key = "<M-0>";
      }
      {
        action = "<Cmd>BufferPin<CR>";
        key = "<M-p>";
      }
      {
        action = "<Cmd>BufferClose<CR>";
        key = "<M-w>";
      }
    ];
    userCommands = {
      Format = {
        range = true;
        command.__raw = ''
          function(args)
            local range = nil
            if args.count ~= -1 then
              local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
              range = {
                start = { args.line1, 0 },
                ["end"] = { args.line2, end_line:len() },
              }
            end
            require("conform").format({ async = true, lsp_format = "fallback", range = range })
          end
        '';
      };
    };
  };
}

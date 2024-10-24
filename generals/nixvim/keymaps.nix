{ ... }:
{
  # For coding time, start with Ctrl
  # For "running", including Markdown preview, start with Meta
  programs.nixvim.keymaps = [
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
      action = "<Cmd>lua require(\"dapui\").toggle()";
      key = "<M-d>";
      mode = "n";
    }
    # Glow: Preview Markdown
    {
      action = "<Cmd>Glow";
      key = "<M-g>";
      mode = "n";
    }
    # Neotree: Summon
    {
      action = "<Cmd>Neotree toggle";
      key = "<C-n>";
    }
    # Undotree: Summon
    {
      action = "<Cmd>UndotreeToggle";
      key = "<C-u>";
    }
    # Trouble: Summon
    {
      action = "<Cmd>Trouble diagnostics";
      key = "<C-o>";
    }
    {
      action = "<Cmd>Trouble lsp";
      key = "<C-p>";
    }
    # Barbar: Navigate between tabs
    {
      action = "<Cmd>BufferPrevious<CR>";
      key = "<C-k>";
    }
    {
      action = "<Cmd>BufferNext<CR>";
      key = "<C-j>";
    }
    {
      action = "<Cmd>BufferMovePrevious<CR>";
      key = "<C-K>";
    } 
    {
      action = "<Cmd>BufferMoveNext<CR>";
      key = "<C-J>";
    }
    {
      action = "<Cmd>BufferGoto 1<CR>";
      key = "<C-1>";
    }
    {
      action = "<Cmd>BufferGoto 2<CR>";
      key = "<C-2>";
    }
    {
      action = "<Cmd>BufferGoto 3<CR>";
      key = "<C-3>";
    }
    {
      action = "<Cmd>BufferGoto 4<CR>";
      key = "<C-4>";
    }
    {
      action = "<Cmd>BufferGoto 5<CR>";
      key = "<C-5>";
    }
    {
      action = "<Cmd>BufferGoto 6<CR>";
      key = "<C-6>";
    }
    {
      action = "<Cmd>BufferGoto 7<CR>";
      key = "<C-7>";
    }
    {
      action = "<Cmd>BufferGoto 8<CR>";
      key = "<C-8>";
    }
    {
      action = "<Cmd>BufferGoto 9<CR>";
      key = "<C-9>";
    }
    {
      action = "<Cmd>BufferLast<CR>";
      key = "<C-0>";
    }
    {
      action = "<Cmd>BufferPin<CR>";
      key = "<C-p>";
    }
    {
      action = "<Cmd>BufferClose<CR>";
      key = "<C-w>";
    }
  ];
}

{ ... }:
{
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
    # Barbar: Navigate between tabs
    {
      action = "<Cmd>BufferPrevious<CR>";
      key = "<A-k>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferNext<CR>";
      key = "<A-j>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferMovePrevious<CR>";
      key = "<A-K>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferMoveNext<CR>";
      key = "<A-J>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferGoto 1<CR>";
      key = "<A-1>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferGoto 2<CR>";
      key = "<A-2>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferGoto 3<CR>";
      key = "<A-3>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferGoto 4<CR>";
      key = "<A-4>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferGoto 5<CR>";
      key = "<A-5>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferGoto 6<CR>";
      key = "<A-6>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferGoto 7<CR>";
      key = "<A-7>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferGoto 8<CR>";
      key = "<A-8>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferGoto 9<CR>";
      key = "<A-9>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferLast<CR>";
      key = "<A-0>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferPin<CR>";
      key = "<A-p>";
      options = {
        silent = true;
      };
    }
    {
      action = "<Cmd>BufferClose<CR>";
      key = "<A-c>";
      options = {
        silent = true;
      };
    }
  ];
}

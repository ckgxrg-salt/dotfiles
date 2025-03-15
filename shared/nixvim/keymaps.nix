{ pkgs, ... }:
{
  # For coding time, start with Meta
  # For "running", including Markdown preview, start with Ctrl
  programs.nixvim = {
    keymaps = [
      # Neovim: Generals
      {
        action = "gj";
        key = "j";
        options.silent = true;
      }
      {
        action = "gk";
        key = "k";
        options.silent = true;
      }
      {
        action = "gj";
        key = "<Down>";
        options.silent = true;
      }
      {
        action = "gk";
        key = "<Up>";
        options.silent = true;
      }
    ];

    # Use legendary to generate rest of keymaps
    extraPlugins = with pkgs.vimPlugins; [
      legendary-nvim
    ];
    extraConfigLua = ''
      require('legendary').setup({
        keymaps = {
          -- Dap & Dap-UI: Enter debugging mode
          {
            '<M-d>',
            function()
              require('dapui').toggle()
            end,
            description = 'Toggle Debug View',
          },

          -- Legendary
          { '<C-p>', ':Legendary<CR>', description = 'Show Command Palette' },

          -- File Manager
          { '<M-b>', ':Yazi<CR>', description = 'Browse Files' },

          -- Undotree
          { '<M-u>', ':UndotreeToggle<CR>', description = 'Toggle Undo Tree' },

          -- Trouble
          { '<M-o>', ':Trouble diagnostics toggle<CR>', description = 'Toggle Diagnostics' },
          { '<M-s>', ':Trouble lsp toggle<CR>', description = 'Toggle LSP View' },
          { '<M-p>', ':TodoTelescope<CR>', description = 'Toggle Todo List' },

          -- DAP
          { '/b', ':DapToggleBreakpoint<CR>', description = 'Add/Remove Breakpoint' },

          -- Twilight
          { '<M-t>', ':Twilight<CR>', description = 'Toggle Code Dimming' },

          -- Bufferline
          { '<C-Right>', ':BufferLineCycleNext<CR>', description = 'Move to Next Tab' },
          { '<C-Left>', ':BufferLineCyclePrev<CR>', description = 'Move to Previous Tab' },
          { '<M-w>', ':bdelete<CR>', description = 'Close Current Tab' },

          -- Hop
          {
            'f',
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
              })
            end,
            opts = { remap = true },
            description = 'Hop After',
          },
          {
            'F',
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
              })
            end,
            opts = { remap = true },
            description = 'Hop Before',
          },
          {
            't',
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
                hint_offset = -1
              })
            end,
            opts = { remap = true },
            description = 'Reimplement After',
          },
          {
            'T',
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
                hint_offset = 1
              })
            end,
            opts = { remap = true },
            description = 'Reimplement Before',
          },

          -- Hover
          {
            'K',
            function()
              require('hover').hover()
            end,
            description = 'Toggle Hover Hint',
          },
        },
        extensions = {
          -- Smart-splits
          smart_splits = {},
        },
      })
    '';
  };
}

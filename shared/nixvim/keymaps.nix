{ pkgs, ... }:
{
  # For coding time, start with Meta
  # For "running", including Markdown preview, start with Ctrl
  programs.nixvim = {
    # Use legendary to generate keymaps
    extraPlugins = with pkgs.vimPlugins; [
      legendary-nvim
    ];
    extraConfigLua = ''
      require('legendary').setup({
        keymaps = {
          -- Allow moving in auto-wrapped lines
          { 'j', 'gj', description = 'Move Downwards' },
          { 'k', 'gk', description = 'Move Upwards' },
          { '<Down>', 'gj', description = 'Move Downwards' },
          { '<Up>', 'gk', description = 'Move Upwards' },

          -- Telescope
          { '<C-t>k', ':Telescope keymaps<CR>', description = 'Show Command Palette' },
          { '<C-t>s', ':Telescope persisted<CR>', description = 'View Sessions' },

          -- File Manager
          { '<M-b>', ':Yazi<CR>', description = 'Browse Files' },

          -- Undotree
          { '<M-u>', ':UndotreeToggle<CR>', description = 'Toggle Undo Tree' },

          -- Trouble
          { '<M-o>', ':Trouble diagnostics toggle<CR>', description = 'Toggle Diagnostics' },
          { '<M-s>', ':Trouble lsp toggle<CR>', description = 'Toggle LSP View' },
          { '<M-p>', ':TodoTelescope<CR>', description = 'Toggle Todo List' },

          -- DAP
          { '<M-d>d', ':DapToggleBreakpoint<CR>', description = 'Add/Remove Breakpoint' },
          {
            '<M-d>ui',
            function()
              require('dapui').toggle()
            end,
            description = 'Toggle Debug View',
          },

          -- Twilight
          { '<M-t>', ':Twilight<CR>', description = 'Toggle Code Dimming' },

          -- Bufferline
          { '<C-S-l>', ':BufferLineCycleNext<CR>', description = 'Move to Next Tab' },
          { '<C-S-h>', ':BufferLineCyclePrev<CR>', description = 'Move to Previous Tab' },
          { '<C-S-w>', ':bdelete<CR>', description = 'Close Current Tab' },

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

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
              require('dapui')}.toggle()
            end,
            description = 'Toggle Debug View';
          }

          -- Legendary
          { '<C-p>', ':Legendary', description = 'Show Command Palette' }

          -- Undotree
          { '<M-u>', ':UndotreeToggle', description = 'Toggle Undo Tree' }

          -- Trouble
          { '<M-o>', ':Trouble diagnostics toggle', description = 'Toggle Diagnostics' }
          { '<M-s>', ':Trouble lsp toggle', description = 'Toggle LSP View' }
          { '<M-p>', ':TodoTelescope', description = 'Toggle Todo List' }

          -- DAP
          { '/b', ':DapToggleBreakpoint', description = 'Add/Remove Breakpoint' }

          -- Hop
          {
            'f',
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
              })
            end,
            opts = { remap = true }
            description = 'Hop After'
          }
          {
            'F',
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
              })
            end,
            opts = { remap = true }
            description = 'Hop Before'
          }
          {
            't',
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
                hint_offset = -1
              })
            end,
            opts = { remap = true }
            description = 'Reimplement After'
          }
          {
            'T',
            function()
              require'hop'.hint_char1({
                direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
                hint_offset = 1
              })
            end,
            opts = { remap = true }
            description = 'Reimplement Before'
          }

          -- Twilight
          { '<M-t>', ':Twilight', description = 'Toggle Code Dimming' }

          -- Hover
          {
            'K',
            function()
              require('hover').hover()
            end,
            description = 'Toggle Hover Hint'
          }
        }
        extensions = {
          -- Smart-splits
          smart_splits = {}
        }
      })
    '';
  };
}

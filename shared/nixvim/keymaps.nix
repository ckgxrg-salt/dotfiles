{ ... }:
# Misc keymaps
{
  programs.nixvim = {
    # which-key to display keymap palette
    plugins = {
      which-key = {
        enable = true;
        settings = {
          preset = "modern";
          spec = [
            {
              __unkeyed = "<Leader>c";
              group = "Components";
              icon = " ";
            }
            {
              __unkeyed = "<Leader>l";
              group = "LSP";
              icon = "󰲒 ";
            }
            {
              __unkeyed = "<Leader>t";
              group = "Telescope";
              icon = "󰭎 ";
            }
            {
              __unkeyed = "<Leader>Movement";
              group = "Movement";
              icon = " ";
            }
          ];
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "j";
        action = "gj";
      }
      {
        mode = "n";
        key = "k";
        action = "gk";
      }
      {
        mode = "n";
        key = "<Down>";
        action = "gj";
      }
      {
        mode = "n";
        key = "<Up>";
        action = "gk";
      }
    ];

    extraConfigLua = ''
      require('legendary').setup({
        keymaps = {

          -- DAP
          { '<M-d>d', ':DapToggleBreakpoint<CR>', description = 'Add/Remove Breakpoint' },
          {
            '<M-d>ui',
            function()
              require('dapui').toggle()
            end,
            description = 'Toggle Debug View',
          },

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
        },
        extensions = {
          -- Smart-splits
          smart_splits = {},
        },
      })
    '';
  };
}

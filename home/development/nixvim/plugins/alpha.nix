{
  plugins.alpha = {
    enable = true;
    layout = [
      {
        type = "padding";
        val = 10;
      }
      {
        opts = {
          hl = "Type";
          position = "center";
        };
        type = "text";
        # "\" must be escaped
        val = [
          "  ___| | ____ ___  ___ __ __ _           "
          " / __| |/ / _` \\ \\/ / '__/ _` |          "
          "| (__|   < (_| |>  <| | | (_| |          "
          " \\___|_|\\_\\__, /_/\\_\\_|  \\__, | 's Neovim"
          "          |___/          |___/           "
        ];
      }
      {
        type = "padding";
        val = 10;
      }
      {
        type = "group";
        opts."inherit" = {
          position = "center";
        };
        val = [
          {
            on_press.__raw = "function() vim.cmd('ene') end";
            opts.shortcut = "n";
            type = "button";
            val = "  New file";
          }
          {
            on_press.__raw = "function() vim.cmd('Telescope projects') end";
            opts.shortcut = "s";
            type = "button";
            val = "  Projects";
          }
          {
            on_press.__raw = "function() vim.cmd('Telescope session-lens') end";
            opts.shortcut = "s";
            type = "button";
            val = "  Sessions";
          }
          {
            on_press.__raw = "function() vim.cmd('SessionRestore') end";
            opts.shortcut = "l";
            type = "button";
            val = "󱑀  Last Session";
          }
          {
            on_press.__raw = "function() vim.cmd('qa') end";
            opts.shortcut = "q";
            type = "button";
            val = " Quit Neovim";
          }
        ];
      }
      {
        type = "padding";
        val = 10;
      }
      {
        opts = {
          hl = "Keyword";
          position = "center";
        };
        type = "text";
        val = "Surprisingly, there's a 'Surprisingly, there's a...'.";
      }
    ];
  };
}

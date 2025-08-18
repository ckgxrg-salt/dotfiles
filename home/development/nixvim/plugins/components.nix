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

    smart-splits = {
      enable = true;
      settings = {
        at_edge = "stop";
      };
    };

    noice = {
      enable = true;
      settings = {
        presets.command_palette = true;
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
  };

  keymaps = [
    {
      mode = "n";
      key = "<A-Tab>";
      action = ":Yazi<CR>";
      options.desc = "Browse Files";
    }
    {
      mode = "n";
      key = "<A-h>";
      action = ":lua require('smart-splits').resize_left()<CR>";
      options.desc = "Resize the Current Split to the Left";
    }
    {
      mode = "n";
      key = "<A-j>";
      action = ":lua require('smart-splits').resize_down()<CR>";
      options.desc = "Resize the Current Split to the Bottom";
    }
    {
      mode = "n";
      key = "<A-k>";
      action = ":lua require('smart-splits').resize_up()<CR>";
      options.desc = "Resize the Current Split to the Top";
    }
    {
      mode = "n";
      key = "<A-l>";
      action = ":lua require('smart-splits').resize_right()<CR>";
      options.desc = "Resize the Current Split to the Right";
    }
    {
      mode = "n";
      key = "<Leader>sh";
      action = ":lua require('smart-splits').move_cursor_left()<CR>";
      options.desc = "Move to the Split Left";
    }
    {
      mode = "n";
      key = "<Leader>sj";
      action = ":lua require('smart-splits').move_cursor_down()<CR>";
      options.desc = "Move to the Split Down";
    }
    {
      mode = "n";
      key = "<Leader>sk";
      action = ":lua require('smart-splits').move_cursor_up()<CR>";
      options.desc = "Move to the Split Up";
    }
    {
      mode = "n";
      key = "<Leader>sl";
      action = ":lua require('smart-splits').move_cursor_right()<CR>";
      options.desc = "Move to the Split Right";
    }
    {
      mode = "n";
      key = "<Leader>sH";
      action = ":lua require('smart-splits').swap_buf_left()<CR>";
      options.desc = "Swap with the Split Left";
    }
    {
      mode = "n";
      key = "<Leader>sJ";
      action = ":lua require('smart-splits').swap_buf_down()<CR>";
      options.desc = "Swap with the Split Down";
    }
    {
      mode = "n";
      key = "<Leader>sK";
      action = ":lua require('smart-splits').swap_buf_up()<CR>";
      options.desc = "Swap with the Split Up";
    }
    {
      mode = "n";
      key = "<Leader>sL";
      action = ":lua require('smart-splits').swap_buf_right()<CR>";
      options.desc = "Swap with the Split Right";
    }
    {
      mode = "n";
      key = "<Leader>sn";
      action = ":vsplit #<CR>";
      options.desc = "Make a new vertical Split";
    }
    {
      mode = "n";
      key = "<Leader>sc";
      action = ":close<CR>";
      options.desc = "Close current Split";
    }
  ];
}

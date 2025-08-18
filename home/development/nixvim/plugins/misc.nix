{
  plugins = {
    web-devicons.enable = true;
    undotree.enable = true;
    telescope.enable = true;
    todo-comments.enable = true;
    lsp-signature.enable = true;

    neoscroll = {
      enable = true;
      settings = {
        stop_eof = false;
      };
    };

    direnv = {
      enable = true;
      settings = {
        direnv_silent_load = 1;
      };
    };

    gitsigns = {
      enable = true;
      settings = {
        attach_to_untracked = true;
        auto_attach = true;
        current_line_blame = true;
        current_line_blame_formatter = " <author>, <author_time> - <summary> ";
      };
    };

    lspsaga = {
      enable = true;
      lightbulb.enable = false;
    };

    guess-indent = {
      enable = true;
      settings.auto_cmd = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<Leader>vu";
      action = ":UndotreeToggle<CR>";
      options.desc = "Toggle Undo Tree";
    }
    {
      mode = "n";
      key = "<Leader>td";
      action = ":Telescope diagnostics<CR>";
      options.desc = "Toggle Diagnostics";
    }
    {
      mode = "n";
      key = "<Leader>tl";
      action = ":Trouble lsp toggle<CR>";
      options.desc = "Toggle LSP View";
    }
    {
      mode = "n";
      key = "<Leader>tt";
      action = ":TodoTelescope<CR>";
      options.desc = "Toggle Todo List";
    }
    {
      mode = "n";
      key = "<Leader>tf";
      action = ":Telescope live_grep<CR>";
      options.desc = "Find in Current Project";
    }
    {
      mode = "n";
      key = "<Leader>tk";
      action = ":Telescope keymaps<CR>";
      options.desc = "Show Command Palette";
    }
    {
      mode = "n";
      key = "<Leader>ts";
      action = ":Telescope persisted<CR>";
      options.desc = "View Sessions";
    }
    {
      mode = "n";
      key = "K";
      action = ":Lspsaga hover_doc<CR>";
      options.desc = "Check Hover Doc";
    }
    {
      mode = "n";
      key = "<Leader>co";
      action = ":Lspsaga outline<CR>";
      options.desc = "Display Outline";
    }
    {
      mode = "n";
      key = "<Leader>cr";
      action = ":Lspsaga rename<CR>";
      options.desc = "Rename Selected";
    }
    {
      mode = "n";
      key = "<Leader>ca";
      action = ":Lspsaga code_action<CR>";
      options.desc = "Display Actions for Selected";
    }
  ];
}

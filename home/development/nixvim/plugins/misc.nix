{
  plugins = {
    web-devicons.enable = true;
    undotree.enable = true;
    neoscroll.enable = true;

    telescope = {
      enable = true;
      highlightTheme = "ivy";
    };

    todo-comments = {
      enable = true;
    };

    hop = {
      enable = true;
      settings = {
        dim_unmatched = true;
        jump_on_sole_occurence = false;
      };
    };

    direnv = {
      enable = true;
      settings = {
        direnv_silent_load = 1;
      };
    };

    git-worktree = {
      enable = true;
      enableTelescope = true;
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

    lsp-signature = {
      enable = true;
    };

    lsp-lines = {
      enable = true;
    };

    lspsaga = {
      enable = true;
      lightbulb.enable = false;
    };

    guess-indent = {
      enable = true;
      settings = {
        auto_cmd = true;
      };
    };
  };

  keymaps = [
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
      key = "<Leader>h";
      action = ":HopChar1<CR>";
      options.desc = "Hop 1 Char";
    }
    {
      mode = "n";
      key = "K";
      action = ":Lspsaga hover_doc<CR>";
      options.desc = "Check Hover Doc";
    }
    {
      mode = "n";
      key = "<Leader>lo";
      action = ":Lspsaga outline<CR>";
      options.desc = "Display Outline";
    }
    {
      mode = "n";
      key = "<Leader>lr";
      action = ":Lspsaga rename<CR>";
      options.desc = "Rename Selected";
    }
    {
      mode = "n";
      key = "<Leader>la";
      action = ":Lspsaga code_action<CR>";
      options.desc = "Display Actions for Selected";
    }
  ];
}

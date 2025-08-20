{
  plugins = {
    web-devicons.enable = true;
    undotree.enable = true;
    telescope.enable = true;
    todo-comments.enable = true;
    lsp-signature.enable = true;
    flash.enable = true;
    mini-bufremove.enable = true;

    mini-surround = {
      enable = true;
      settings = {
        n_lines = 50;
        respect_selection_type = true;
      };
    };

    mini-pairs = {
      enable = true;
      settings = {
        modes = {
          command = true;
        };
      };
    };

    smear-cursor = {
      enable = true;
      settings = {
        stiffness = 0.8;
        trailing_stiffness = 0.5;
        stiffness_insert_mode = 0.7;
        trailing_stiffness_insert_mode = 0.7;
        damping = 0.95;
        damping_insert_mode = 0.95;
        distance_stop_animating = 0.5;
      };
    };

    neoscroll = {
      enable = true;
      settings = {
        stop_eof = false;
      };
    };

    nvim-lightbulb = {
      enable = true;
      settings = {
        sign = {
          enabled = true;
          text = "";
          lens_text = "";
        };
        number.enabled = true;
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

    guess-indent = {
      enable = true;
      settings.auto_cmd = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<Leader>w";
      action.__raw = "function() MiniBufremove.delete() end";
      options.desc = "Close current buffer";
    }
    {
      mode = "n";
      key = "<Leader>q";
      action = ":close<CR>";
      options.desc = "Close current window";
    }
    {
      mode = "n";
      key = "<Leader>eu";
      action = ":UndotreeToggle<CR>";
      options.desc = "Undo tree";
    }
    {
      mode = "n";
      key = "<Leader>tt";
      action = ":TodoTelescope<CR>";
      options.desc = "Todo list";
    }
    {
      mode = "n";
      key = "<Leader>tf";
      action = ":Telescope live_grep<CR>";
      options.desc = "Find in current project";
    }
    {
      mode = "n";
      key = "<Leader>tk";
      action = ":Telescope keymaps<CR>";
      options.desc = "Command palette";
    }
    {
      mode = "n";
      key = "<Leader>ts";
      action = ":Telescope session-lens<CR>";
      options.desc = "Sessions";
    }
  ];
}

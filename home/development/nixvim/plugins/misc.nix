{
  plugins = {
    web-devicons.enable = true;
    auto-session.enable = true;
    undotree.enable = true;
    todo-comments.enable = true;
    lsp-signature.enable = true;
    flash.enable = true;
    mini-bufremove.enable = true;

    telescope = {
      enable = true;
      settings = {
        pickers = {
          keymaps.theme = "dropdown";
          live_grep.theme = "dropdown";
        };
      };
    };

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
      key = "<leader>w";
      action.__raw = "function() MiniBufremove.delete() end";
      options.desc = "Close current buffer";
    }
    {
      mode = "n";
      key = "<leader>q";
      action = ":close<CR>";
      options.desc = "Close current window";
    }
    {
      mode = "n";
      key = "<leader>eu";
      action = ":UndotreeToggle<CR>";
      options.desc = "Undo tree";
    }
    {
      mode = "n";
      key = "<leader>tt";
      action = ":Telescope todo-comments theme=dropdown<CR>";
      options.desc = "Todo list";
    }
    {
      mode = "n";
      key = "<leader>tf";
      action = ":Telescope live_grep<CR>";
      options.desc = "Find in current project";
    }
    {
      mode = "n";
      key = "<leader>tk";
      action = ":Telescope keymaps<CR>";
      options.desc = "Command palette";
    }
    {
      mode = "n";
      key = "<leader>ts";
      action = ":Telescope session-lens<CR>";
      options.desc = "Sessions";
    }
  ];
}

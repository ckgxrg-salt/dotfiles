{ ... }:
{
  imports = [
    ./completions.nix
    ./debug.nix
    ./syntax.nix
    ./langs.nix
    ./manual.nix
  ];
  programs.nixvim.plugins = {
    # Components
    # Markdown preview
    glow = {
      enable = true;
      settings = {
        border = "double";
        pager = true;
      };
    };
    # File explorer
    neo-tree = {
      enable = true;
      enableGitStatus = true;
      popupBorderStyle = "double";
    };
    # Tab bar
    barbar = {
      enable = true;
      settings = {
        icons.preset = "powerline";
      };
    };
    # Status bar
    lualine = {
      enable = true;
      settings = {
        options = {
          globalstatus = true;
        };
      };
    };
    # Startup page
    dashboard = {
      enable = true;
      settings = {
        config = {
          header = [
            "   ,##.                   ,==."
            " ,#    #.                 \\ o ',"
            "#        #     _     _     \\    \\"
            "#        #    (_)   (_)    /    ; "
            " `#    #'                 /   .'  "
            "   `##'                   \"==\""
          ];
          footer = [
            "Neovim !"
          ];
          project.enable = true;
        };
      };
    };
    # Terminal
    toggleterm = {
      enable = true;
      settings = {
        close_on_exit = true;
        direction = "horizontal";
      };
    };
    # Fancy icons
    web-devicons.enable = true;
    # Enhanced UI
    nui = {
      enable = true;
    };
    noice = {
      enable = true;
      settings = {
        presets = {
          command_palette = true;
        };
        hover = {
          silent = true;
        };
      };
    };
    # Notifications
    notify = {
      enable = true;
      stages = "slide";
      topDown = true;
      timeout = 3000;
    };

    # Coding Experience
    # Dim inactive code
    twilight = {
      enable = true;
      settings = {
        dimming.alpha = 0.3;
      };
    };
    # Highlights
    illuminate = {
      enable = true;
      underCursor = true;
      providers = [
        "lsp"
        "treesitter"
        "regex"
      ];
    };
    # Undo tree
    undotree.enable = true;
    # Fuzzy search
    telescope = {
      enable = true;
      highlightTheme = "ivy";
    };
    # Todo
    todo-comments = {
      enable = true;
    };
    # Motions
    leap = {
      enable = true;
      addDefaultMappings = true;
    };

    # Project management
    project-nvim = {
      enable = true;
      enableTelescope = true;
      settings = {
        detection_methods = [
          "lsp"
          "pattern"
        ];
        patterns = [
          ".git"
          "flake.nix"
          "Makefile"
          "build.ninja"
          "Cargo.toml"
          "build.gradle"
        ];
        scope_chdir = "win";
        silent_chdir = false;
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
        word_diff = true;
      };
    };
  };
}

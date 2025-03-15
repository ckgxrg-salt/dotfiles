{ ... }:
{
  imports = [
    ./completions.nix
    ./debug.nix
    ./lsp.nix
    ./syntax.nix
    ./ui.nix
  ];
  programs.nixvim.plugins = {
    # Dim inactive code
    twilight = {
      enable = true;
      settings = {
        dimming = {
          alpha = 1;
        };
      };
    };

    # Fancy icons
    web-devicons.enable = true;
    # Undo tree
    undotree.enable = true;
    # Better scroll
    neoscroll.enable = true;

    # Fuzzy search
    telescope = {
      enable = true;
      highlightTheme = "ivy";
    };

    # Todo
    todo-comments = {
      enable = true;
    };

    # Better motion
    hop = {
      enable = true;
      settings = {
        dim_unmatched = true;
        jump_on_sole_occurence = false;
      };
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
          "Cargo.toml"
          "./gradlew"
        ];
        scope_chdir = "global";
        silent_chdir = true;
      };
    };

    # Session management
    persisted = {
      enable = true;
      enableTelescope = true;
    };

    # Direnv Integration
    direnv = {
      enable = true;
      settings = {
        direnv_silent_load = 1;
      };
    };

    # Git Integration
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

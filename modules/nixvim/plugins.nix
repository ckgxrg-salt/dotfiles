{ ... }: {
  programs.nixvim.plugins = {
    # Completion
    coq-nvim = {
      enable = true;
      installArtifacts = true;
      settings = {
        auto_start = "shut-up";
      };
    };
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
      globalstatus = true;
      theme = "everforest";
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
          week_header.enable = true;
          project.enable = false;
        };
      };
    };
    # Terminal
    
    # Quickfix
    nvim-bqf = {
      enable = true;
      autoEnable = true;
    };
    # Treesitter
    treesitter = {
      enable = true;
      gccPackage = null;
    };
    # Dim inactive code
    twilight = {
      enable = true;
      settings = {
        dimming.alpha = 0.3;
      };
    };
    # Undo tree
    undotree = {
      enable = true;
    };
    # Working with Nix
    nix = {
      enable = true;
    };
    nix-develop = {
      enable = true;
    };
  };
}
{ pkgs, lib, ... }: {
  programs.nixvim.plugins = {
    # Completion & Snippets
    cmp = {
      enable = true;
      autoEnableSources = true;
      settings = {
        snippet = {
          expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        };
        sources = [
          { name = "buffer"; }
          { name = "cmdline"; }
          { name = "path"; }
          { name = "luasnip"; }
          { name = "nvim_lsp"; }
        ];
      };
    };
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-cmdline.enable = true;
    cmp_luasnip.enable = true;
    luasnip = {
      enable = true;
      fromVscode = [];
      settings = {
        enable_autosnippets = true;
      };
    };
    friendly-snippets.enable = true;
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
          theme = "everforest";
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
    undotree.enable = true;
    # Fuzzy search
    telescope = {
      enable = true;
      highlightTheme = "ivy";
    };

    # Project management
    project-nvim = {
      enable = true;
      enableTelescope = true;
      settings = {
        detection_methods = [ "lsp" "pattern" ];
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

    # Working with Nix
    nix = {
      enable = true;
    };
    nix-develop = {
      enable = true;
    };

    # Working with Java
    nvim-jdtls = {
      enable = true;
      rootDir = { __raw = "require('jdtls.setup').find_root({'build.gradle', 'pom.xml'})"; };
      cmd = [ "Surprisingly, you cannot use Lua code here, though this option is mandatory. " ];
      extraOptions.cmd = [
        "${lib.getExe pkgs.jdt-language-server}"
        "-configuration"
        { __raw = "vim.fn.expand(\"$XDG_CACHE_HOME/jdtls/config\")"; }
        "-data"
        { __raw = "require('jdtls.setup').find_root({'build.gradle', 'pom.xml'})"; }
      ];
    };
  };
}
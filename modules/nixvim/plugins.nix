{ pkgs, lib, ... }: {
  programs.nixvim.plugins = {
    # Completion & Snippets
    cmp = {
      enable = true;
      settings = {
        snippet = {
          expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        };
        sources = {
          __raw = ''
            cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
            }, {
              { name = 'buffer' },
            })
          '';
        };
      };
    };
    cmp_luasnip.enable = true;
    luasnip = {
      enable = true;
      fromVscode = [
        {
          lazyLoad = true;
        }
      ];
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
      detectionMethods = [ "lsp" "pattern" ];
      patterns = [
        ".git"
        "flake.nix"
        "Makefile"
        "build.ninja"
        "Cargo.toml"
        "build.gradle"
      ];
      scopeChdir = "win";
      silentChdir = false;
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
      rootDir = {
        __raw = "require('jdtls.setup').find_root({'.git', 'build.gradle'})";
      };
      cmd = [ "Not Applicable" ];
      extraOptions.cmd = [
        "${lib.getExe pkgs.jdt-language-server}"
        "-configuration"
        { __raw = "vim.fn.expand(\"$XDG_CACHE_HOME/jdtls/config\")"; }
        "-data"
        { __raw = "require('jdtls.setup').find_root({'.git', 'build.gradle'})"; }
      ];
    };
  };
}
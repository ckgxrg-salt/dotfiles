{
  config,
  pkgs,
  lib,
  ...
}:
# Plugins that assist coding
{
  config = lib.mkIf config.development.neovim.enable {
    programs.nixvim = {
      plugins = {
        # Generate statusline content from LSP
        lsp-status = {
          enable = true;
          settings = {
            component_separator = " | ";
            current_function = true;
            show_filename = true;
            diagnostics = false;
          };
        };

        # Get hint from LSP
        lsp-signature = {
          enable = true;
        };

        # Show diagnostics from LSP
        lsp-lines = {
          enable = true;
        };

        # Enhance LSP experience
        lspsaga = {
          enable = true;
          lightbulb.enable = false;
        };

        # Working with Nix
        nix = {
          enable = true;
        };
        nix-develop = {
          enable = true;
        };

        # Markdown preview
        markdown-preview = {
          enable = true;
          settings = {
            browser = "firefox";
            theme = "dark";
          };
        };

        # Deduce indentation width
        guess-indent = {
          enable = true;
          settings = {
            auto_cmd = true;
          };
        };

        # Other language servers
        lsp = {
          enable = true;
          inlayHints = true;
          servers = {
            clangd.enable = true;
            marksman.enable = true;
            nil_ls.enable = true;
            ts_ls.enable = true;
            cssls.enable = true;
          };
        };

        # Formatting
        conform-nvim = {
          enable = true;
          settings = {
            formatters_by_ft = {
              cpp = [ "clang-format" ];
              rust = [ "rustfmt" ];
              java = [ "google-java-format" ];
              nix = [ "nixfmt" ];
              markdown = [ "markdownfmt" ];
              css = [ "stylelint" ];
              "_" = [
                "squeeze_blanks"
                "trim_whitespace"
                "trim_newlines"
              ];
            };
            default_format_opts = {
              lsp_format = "fallback";
            };
            notify_no_formatters = true;
            format_on_save = {
              timeout_ms = 2000;
            };
          };
        };

        # Linting
        lint = {
          enable = true;
          lintersByFt = {
            cpp = [ "clangtidy" ];
            rust = [ "clippy" ];
            java = [ "checkstyle" ];
            nix = [ "deadnix" ];
            css = [ "stylelint" ];
          };
          linters = {
            checkstyle = {
              config_file = "/google_checks.xml";
            };
          };
        };

        # Treesitter
        treesitter = {
          enable = true;
          folding = true;

          nixGrammars = true;
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            json
            markdown
            nix
            toml
            rust
            java
            javascript
            cpp
          ];

          settings = {
            highlight = {
              enable = true;
              additional_vim_regex_highlighting = false;
            };
            indent.enable = true;
            rainbow = {
              enable = true;
              extended_mode = true;
              max_file_lines = "nil";
            };
          };
        };
      };
    };
    keymaps = [
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
  };
}

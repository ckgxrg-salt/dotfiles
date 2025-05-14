{ pkgs, ... }:
{
  programs.nixvim.plugins = {
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

    # Deduce indentation width
    guess-indent = {
      enable = true;
      settings = {
        auto_cmd = true;
      };
    };
  };
}

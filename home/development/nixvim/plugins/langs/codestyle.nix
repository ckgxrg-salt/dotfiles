{
  plugins = {
    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          cpp = [ "clang-format" ];
          rust = [ "rustfmt" ];
          java = [ "google-java-format" ];
          nix = [ "nixfmt" ];
          markdown = [ "markdownfmt" ];
          scss = [ "prettier" ];
          css = [ "prettier" ];
          typescript = [ "prettier" ];
          typescriptreact = [ "prettier" ];
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

    lint = {
      enable = true;
      lintersByFt = {
        cpp = [ "clangtidy" ];
        rust = [ "clippy" ];
        java = [ "checkstyle" ];
        nix = [ "deadnix" ];
        scss = [ "eslint" ];
        css = [ "eslint" ];
        typescript = [ "eslint" ];
        typescriptreact = [ "eslint" ];
      };
      linters = {
        checkstyle = {
          config_file = "/google_checks.xml";
        };
      };
    };
  };
}

{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    # Diagnostics list
    trouble = {
      enable = true;
      settings = {
        auto_close = false;
        auto_jump = true;
        open_no_results = true;
      };
    };
    # Formatting
    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          rust = [ "rustfmt" ];
          java = [ "google-java-format" ];
          nix = [ "nixfmt" ];
          markdown = [ "markdownfmt" ];
          "_" = [
            "squeeze_blanks"
            "trim_whitespace"
            "trim_newlines"
          ];
        };
        default_format_opts = {
          lsp_format = "fallback";
        };
        notify_no_formatters = false;
        format_on_save = {
          timeout_ms = 2000;
        };
      };
    };
    # Linting
    lint = {
      enable = true;
      lintersByFt = {
        rust = [ "clippy" ];
        java = [ "checkstyle" ];
        nix = [ "deadnix" ];
      };
      linters = {
        checkstyle = {
          config_file = "/google_checks.xml";
        };
      };
    };
    # Indent lines
    indent-blankline = {
      enable = true;
      luaConfig.pre = ''
        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
          vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
          vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
          vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
          vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
          vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end)
      '';
      settings = {
        exclude = {
          buftypes = [
            "terminal"
            "nofile"
            "quickfix"
            "prompt"
          ];
          filetypes = [
            "lspinfo"
            "packer"
            "checkhealth"
            "help"
            "man"
            "gitcommit"
            "TelescopePrompt"
            "TelescopeResults"
            "dashboard"
            "''"
          ];
        };
        scope = {
          enabled = true;
          injected_languages = true;
        };
        indent = {
          highlight = [
            "RainbowRed"
            "RainbowYellow"
            "RainbowBlue"
            "RainbowOrange"
            "RainbowGreen"
            "RainbowViolet"
            "RainbowCyan"
          ];
        };
      };
    };
    # Better quickfix
    nvim-bqf = {
      enable = true;
      autoEnable = true;
      autoResizeHeight = true;
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
}

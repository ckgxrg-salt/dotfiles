{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.development.neovim;
in
{

  options.development.neovim = {
    enable = mkEnableOption "Enable default Nixvim settings";
  };

  config = mkIf cfg.enable {
    stylix.targets.neovim = {
      enable = true;
      plugin = "base16-nvim";
      transparentBackground = {
        main = true;
        numberLine = true;
        signColumn = true;
      };
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      withRuby = false;
      withPython3 = false;

      # List all plugins here
      plugins = with pkgs.vimPlugins; [
        # Completion
        blink-cmp
        friendly-snippets

        # Debug
        nvim-dap
        nvim-dap-view
        nvim-dap-virtual-text

        # Interface
        yazi-nvim
        fidget-nvim
        edgy-nvim
        codecompanion-nvim
        hlchunk-nvim
        trouble-nvim
        inc-rename-nvim
        aerial-nvim
        alpha-nvim
        nvim-notify

        # Decorations
        smear-cursor-nvim
        tiny-glimmer-nvim
        neoscroll-nvim

        # Lines
        bufferline-nvim
        lualine-nvim
        vim-illuminate

        # Misc
        nvim-web-devicons
        auto-session
        undotree
        todo-comments-nvim
        lsp_signature-nvim
        flash-nvim
        mini-bufremove
        telescope-nvim
        wtf-nvim
        mini-surround
        nvim-autopairs
        direnv-vim
        gitsigns-nvim
        indent-o-matic

        # Test
        neotest

        # Keybind
        which-key-nvim

        # Language-specific
        nvim-lspconfig
        haskell-tools-nvim
        nvim-jdtls
        markview-nvim
        rustaceanvim

        # Codestyle
        conform-nvim
        nvim-lint
        (nvim-treesitter.withPlugins (
          grammars: with grammars; [
            json
            latex
            markdown
            nix
            toml
            rust
            java
            haskell
            typescript
            cpp
          ]
        ))
      ];

      # LSP servers, formatters and linters that are not specific to projects
      extraPackages = with pkgs; [
        marksman
        nil
        nixfmt-rfc-style
        deadnix
      ];

      extraLuaConfig = lib.fileContents ./init.lua;
    };

    xdg.configFile = {
      "nvim/lua/plugins" = {
        source = ./plugins;
        recursive = true;
      };
      "nvim/after/ftplugin" = {
        source = ./ftplugin;
        recursive = true;
      };
    };
  };
}

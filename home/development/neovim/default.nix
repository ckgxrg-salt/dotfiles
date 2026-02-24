{
  config,
  lib,
  pkgs,
  ckgs,
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
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      withRuby = false;
      withPython3 = false;

      # List all plugins here
      plugins = with pkgs.vimPlugins; [
        # Utilities
        nvim-web-devicons
        telescope-nvim
        flash-nvim

        # Completion
        blink-cmp
        friendly-snippets

        # Debug
        nvim-dap
        nvim-dap-view
        nvim-dap-virtual-text

        # Test
        nvim-nio
        neotest

        # Interface
        yazi-nvim
        fidget-nvim
        edgy-nvim
        alpha-nvim
        barbar-nvim
        lualine-nvim
        vim-illuminate
        toggleterm-nvim

        # Widgets
        codecompanion-nvim
        hlchunk-nvim
        trouble-nvim
        inc-rename-nvim
        aerial-nvim
        undotree
        wtf-nvim

        # Decorations
        smear-cursor-nvim
        tiny-glimmer-nvim
        neoscroll-nvim

        # Session
        resession-nvim
        ckgs.nvim.pick-resession-nvim
        project-nvim
        direnv-vim

        # Misc
        ckgs.nvim.im-select-nvim
        todo-comments-nvim
        lsp_signature-nvim
        mini-surround
        nvim-autopairs
        gitsigns-nvim
        indent-o-matic

        # Help & Support
        which-key-nvim

        # Language-specific
        nvim-lspconfig
        haskell-tools-nvim
        nvim-jdtls
        markview-nvim
        csvview-nvim
        rustaceanvim
        vimtex

        # Codestyle
        conform-nvim
        nvim-lint
        (nvim-treesitter.withPlugins (
          grammars: with grammars; [
            latex
            markdown
            nix
            json
            toml
            yaml
            typst
            rust
            java
            haskell
            sql
            typescript
            cpp
          ]
        ))
      ];

      # LSP servers, formatters and linters that are not specific to projects
      extraPackages = with pkgs; [
        marksman
        nil
        nixfmt
        deadnix

        fd
      ];

      initLua = lib.fileContents ./init.lua;
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

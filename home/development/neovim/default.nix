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
        alpha-nvim
        bufferline-nvim
        lualine-nvim
        vim-illuminate

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
        ckgs.nvim.possession-nvim
        project-nvim
        direnv-vim

        # Misc
        todo-comments-nvim
        lsp_signature-nvim
        flash-nvim
        mini-bufremove
        mini-surround
        nvim-autopairs
        gitsigns-nvim
        indent-o-matic

        # Test
        neotest

        # Help & Support
        which-key-nvim
        ckgs.nvim.neovim-tips

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
            latex
            markdown
            nix
            json
            toml
            yaml
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

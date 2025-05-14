{ config, lib, ... }:
with lib;
let
  cfg = config.development.neovim;
in
{

  options.development.neovim = {
    enable = mkEnableOption "Enable default Neovim settings";
  };

  imports = [
    ./keymaps.nix
    ./plugins
    ./langs
  ];

  config = mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      performance.combinePlugins = {
        # TODO:Currently does not work with smart-splits
        enable = false;
        standalonePlugins = [
          "nvim-treesitter"
        ];
      };
      withRuby = false;
      clipboard.providers.wl-copy.enable = true;

      # Options
      globals = {
        mapleader = " ";
      };
      opts = {
        completeopt = [
          "menuone"
          "noselect"
          "noinsert"
        ];
        clipboard = "unnamedplus";
        linebreak = true;
        foldlevelstart = 99;
        number = true;
        relativenumber = true;
        mouse = "a";
        tabstop = 2;
        shiftwidth = 2;
      };

      # Diagnostics
      diagnostic.settings = {
        virtual_text = true;
        signs = true;
        update_in_insert = true;
        underline = true;
        severity_sort = false;
        float = {
          border = "rounded";
          source = "always";
          header = "";
          prefix = "<- ";
        };
      };
    };
  };
}

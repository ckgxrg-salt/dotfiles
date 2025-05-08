{ ... }:
{
  # The Neovim editos
  imports = [
    ./keymaps.nix
    ./plugins
    ./langs
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    performance.combinePlugins = {
      enable = true;
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
}

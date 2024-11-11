{ ... }:
{
  # The Neovim editos
  imports = [
    ./keymaps.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    clipboard.providers.wl-copy.enable = true;

    # Options
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
      tabstop = 4;
      shiftwidth = 2;
    };

    # Diagnostics
    diagnostics = {
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

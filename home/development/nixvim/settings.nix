{
  performance.combinePlugins = {
    enable = true;
    standalonePlugins = [
      "codecompanion.nvim"
      "markview.nvim"
      "conform.nvim"
      "nvim-jdtls"
    ];
  };

  clipboard = {
    register = "unnamedplus";
    providers.wl-copy.enable = true;
  };

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
    wrap = true;
    linebreak = true;
    breakindent = true;
    foldlevelstart = 99;
    number = true;
    relativenumber = true;
    mouse = "a";
    softtabstop = 4;
    shiftwidth = 2;
    expandtab = true;
    splitright = true;
    winborder = "single";
  };

  diagnostic.settings = {
    virtual_text = true;
    signs = true;
    update_in_insert = true;
    underline = true;
  };
}

{
  performance.combinePlugins = {
    enable = true;
    standalonePlugins = [
      "smart-splits.nvim"
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
    linebreak = true;
    foldlevelstart = 99;
    number = true;
    relativenumber = true;
    mouse = "a";
    softtabstop = 4;
    shiftwidth = 2;
    expandtab = true;
    splitright = true;
  };

  # Diagnostics
  diagnostic.settings = {
    virtual_lines = true;
    signs = true;
    update_in_insert = true;
    underline = true;
    severity_sort = true;
  };
}

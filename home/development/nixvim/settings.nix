{
  performance.combinePlugins = {
    enable = true;
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
    tabstop = 2;
    shiftwidth = 2;
    splitright = true;
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
}

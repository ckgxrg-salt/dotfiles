{
  plugins = {
    markview = {
      enable = true;
      settings = {
        preview = {
          filetypes = [
            "markdown"
            "codecompanion"
          ];
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<Leader>em";
      action = ":Markview toggle<CR>";
      options.desc = "Toggle markdown view";
    }
  ];
}

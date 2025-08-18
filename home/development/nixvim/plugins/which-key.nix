{
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "modern";
      spec = [
        {
          __unkeyed = "<Leader>v";
          group = "Views";
          icon = " ";
        }
        {
          __unkeyed = "<Leader>c";
          group = "Code Actions";
          icon = "󰲒 ";
        }
        {
          __unkeyed = "<Leader>t";
          group = "Telescope";
          icon = "󰭎 ";
        }
        {
          __unkeyed = "<Leader>s";
          group = "Splits";
          icon = " ";
        }
        {
          __unkeyed = "<Leader>d";
          group = "Debug";
          icon = " ";
        }
      ];
    };
  };

  keymaps = [
    {
      mode = [
        "n"
        "v"
        "i"
      ];
      key = "<F1>";
      action = ":WhichKey<CR>";
      options.desc = "Show keymaps";
    }
  ];
}

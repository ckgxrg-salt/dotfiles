{
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "classic";
      spec = [
        {
          __unkeyed = "<Leader>v";
          group = "Views";
          icon = " ";
        }
        {
          __unkeyed = "<Leader>l";
          group = "Code Actions";
          icon = "󰲒 ";
        }
        {
          __unkeyed = "<Leader>t";
          group = "Telescope";
          icon = "󰭎 ";
        }
        {
          __unkeyed = "<Leader>m";
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

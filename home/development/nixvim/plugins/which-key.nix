{
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "modern";
      spec = [
        {
          __unkeyed = "<Leader>e";
          group = "Editor";
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
          __unkeyed = "<Leader>d";
          group = "Debug";
          icon = " ";
        }
        {
          __unkeyed = "<Leader>r";
          group = "Test";
          icon = "󰙨 ";
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

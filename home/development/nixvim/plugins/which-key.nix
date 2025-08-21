{
  plugins.which-key = {
    enable = true;
    settings = {
      preset = "modern";
      spec = [
        {
          __unkeyed = "<leader>e";
          group = "Editor";
          icon = " ";
        }
        {
          __unkeyed = "<leader>c";
          group = "Code Actions";
          icon = "󰲒 ";
        }
        {
          __unkeyed = "<leader>t";
          group = "Telescope";
          icon = "󰭎 ";
        }
        {
          __unkeyed = "<leader>d";
          group = "Debug";
          icon = " ";
        }
        {
          __unkeyed = "<leader>r";
          group = "Test";
          icon = "󰙨 ";
        }

        # Filtype specific keymaps
        {
          __unkeyed = "<leader>n";
          group = "Notebook";
          icon = "󰠮 ";
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

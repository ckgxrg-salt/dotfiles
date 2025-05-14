{ ... }:
# Misc keymaps
{
  programs.nixvim = {
    # which-key to display keymap palette
    plugins = {
      which-key = {
        enable = true;
        settings = {
          preset = "modern";
          spec = [
            {
              __unkeyed = "<Leader>c";
              group = "Components";
              icon = " ";
            }
            {
              __unkeyed = "<Leader>l";
              group = "LSP";
              icon = "󰲒 ";
            }
            {
              __unkeyed = "<Leader>t";
              group = "Telescope";
              icon = "󰭎 ";
            }
            {
              __unkeyed = "<Leader>m";
              group = "Movement";
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
    };

    keymaps = [
      {
        mode = "n";
        key = "j";
        action = "gj";
      }
      {
        mode = "n";
        key = "k";
        action = "gk";
      }
      {
        mode = "n";
        key = "<Down>";
        action = "gj";
      }
      {
        mode = "n";
        key = "<Up>";
        action = "gk";
      }
    ];
  };
}

{ ... }:
{
  imports = [ ../../../shared/nixvim ];

  # Neovim themes
  programs.nixvim = {
    colorscheme = "tokyonight-storm";
    plugins.lualine.settings.options.theme = "tokyonight-storm";
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        day_brightness = 0.9;
        dim_inactive = true;
      };
    };
  };

  # GUI
  programs.neovide = {
    enable = true;
    settings = {
      font = {
        size = 16;
      };
    };
  };
}

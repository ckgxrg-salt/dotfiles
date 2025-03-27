{ pkgs, ... }:
{
  imports = [ ../../../shared/nixvim ];

  # Neovim themes
  programs.nixvim = {
    colorscheme = "everforest";
    plugins.lualine.settings.options.theme = "everforest";
    extraPlugins = [ pkgs.vimPlugins.everforest ];
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

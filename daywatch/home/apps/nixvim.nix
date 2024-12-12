{ pkgs, ... }:
{
  imports = [ ../../../generals/nixvim ];
  # Neovim themes
  programs.nixvim = {
    colorscheme = "everforest";
    plugins.lualine.settings.options.theme = "everforest";
    extraPlugins = [ pkgs.vimPlugins.everforest ];
  };
}

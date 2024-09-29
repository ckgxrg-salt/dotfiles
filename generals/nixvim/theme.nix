{ pkgs, ... }:
{
  # Neovim themes
  programs.nixvim = {
    colorscheme = "everforest";
    extraPlugins = [ pkgs.vimPlugins.everforest ];
  };
}

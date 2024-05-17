{ config, pkgs, ... }:
{

  # The NeoVim Editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

}
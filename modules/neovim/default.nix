{ config, ... }:
{
  # The NeoVim Editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
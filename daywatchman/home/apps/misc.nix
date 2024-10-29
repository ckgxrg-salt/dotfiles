{ pkgs, ... }:
{
  # btop System Monitor
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      color_theme = "everforest-dark-hard";
    };
  };
}

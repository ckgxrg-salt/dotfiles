{ config, pkgs, ... }:
{
  # Include home modules
  imports = [
    ../../modules/hyprland/twirisa.nix
    ../../modules/zsh
    ../../modules/utils
    ./naikunze.nix
    ./theme
  ];

  # Input Method
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-chinese-addons ];
  };

  # User and home directory
  home.username = "ckgxrg";
  home.homeDirectory = "/home/ckgxrg";

  # Home Manager
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}

{ config, pkgs, ... }:
# Home-manager configuration for Cshelipix
{
  # Include home modules
  imports = [
    ../../modules/hyprland/cshelipix
    ../../modules/zsh
    ../../modules/utils
    ../../modules/neovim
    ./bakage.nix
    ../../modules/theme/gedicine.nix
    ../../modules/dev
  ];

  # Input Method
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-nord
      fcitx5-rime
    ];
  };

  # User and home directory
  home.username = "ckgxrg";
  home.homeDirectory = "/home/ckgxrg";

  # Home Manager
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}

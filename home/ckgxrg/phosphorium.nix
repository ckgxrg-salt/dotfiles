{ config, pkgs, ... }:
# Home-manager configuration for Twirisa
{
  # Include home modules
  imports = [
    ../../modules/hyprland/twirisa
    ../../modules/zsh
    ../../modules/utils
    ../../modules/neovim
    ./naikunze.nix
    ./theme/firefly.nix
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
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}

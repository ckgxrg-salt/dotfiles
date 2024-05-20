{ config, pkgs, ... }:
# Home-manager configuration for Radilopa
{
  # Include home modules
  imports = [
    ../../modules/hyprland/radilopa.nix
    ../../modules/zsh
    ../../modules/utils
    ../../modules/neovim
    ./frostgate.nix
    ./theme/paralace.nix
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

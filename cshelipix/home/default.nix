{ config, pkgs, ... }:
# Home-manager configuration for Cshelipix
{
  # Include home modules
  imports = [
    ./desktop/hyprland.nix
    ./package.nix
    ./theme.nix
    #../../modules/ags
    ../../modules/terminal/zsh.nix
    ../../modules/terminal/neovim.nix
    ../../modules/terminal/alacritty.nix
    ../../modules/dev/langs.nix
    ../../modules/utils
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
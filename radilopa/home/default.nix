{ pkgs, ... }:
# Home-manager configuration for Radilopa
{
  # Include home modules
  imports = [
    ./desktop/hyprland.nix
    ./package.nix
    ./theme.nix
    ../../modules/terminal/accessories.nix
    ../../modules/terminal/alacritty.nix
    ../../modules/terminal/bash.nix
    ../../modules/terminal/nushell.nix
    ../../modules/nixvim
    ../../modules/utils
    ../../modules/utils/qutebrowser.nix
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

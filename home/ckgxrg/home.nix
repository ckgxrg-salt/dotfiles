{ config, pkgs, ... }:
{
  # Include home modules
  imports = [
    ../../modules/hyprland
    ../../modules/zsh
    ../../modules/cli-tools
    ./package.nix
  ];

  # User and home directory
  home.username = "ckgxrg";
  home.homeDirectory = "/home/ckgxrg";

  # Home Manager
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}

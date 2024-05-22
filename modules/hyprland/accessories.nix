{ config, pkgs, inputs, ... }:
{
  imports = [
    ./waybar.nix
    ./hypreco.nix
    ./wlogout.nix
  ];

  # Hyprland accessories
  home.packages = with pkgs; [
    waypaper
    swww
    brightnessctl
    libnotify
    libsForQt5.polkit-kde-agent
    inputs.hyprswitch.packages.${pkgs.system}.default
  ];

  # Mako the Notification Daemon
  services.mako = {
    enable = true;
    anchor = "top-right";
    borderRadius = 15;
    defaultTimeout = 15000;
    font = "maple mono 12";
    height = 150;
    width = 450;
    icons = true;
    iconPath = "/run/current-system/sw/share/icons/hicolor:/run/current-system/sw/share/icons/pixmaps";
    maxIconSize = 64;
    maxVisible = 3;
  };

  # Rofi the Application Launcher
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    location = "top-left";
    font = "Maple Mono 14";
    theme = "material";
  };

  # UDiskie the Auto-Mount Manager
  services.udiskie = {
    enable = true;
    notify = true;
    tray = "auto";
  };

  services.cliphist = {
    enable = true;
  };

  # Config file
  home.file.".config/waypaper/config.ini".source = ./waypaper.ini;
}
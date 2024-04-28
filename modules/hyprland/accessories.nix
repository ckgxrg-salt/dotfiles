{ config, pkgs, ... }:
{
  imports = [ ./waybar.nix ];

  # Hyprland accessories
  home.packages = with pkgs; [
    waypaper
    swww
    brightnessctl
    hyprlock
    libnotify
    libsForQt5.polkit-kde-agent
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

  # WLogout the Logout Menu
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "End Session";
        keybind = "l";
      }
    ];
  };

  # UDiskie the Auto-Mount Manager
  services.udiskie = {
    enable = true;
    notify = true;
    tray = "auto";
  };

  # Config file
  home.file.".config/waypaper/config.ini".source = ./waypaper.ini;
}
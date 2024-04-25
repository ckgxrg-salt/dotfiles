{ config, pkgs, ... }:
{
  # Hyprland accessories
  home.packages = with pkgs; [
    waybar
    waypaper
    swww
    mako
    libnotify
    rofi-wayland
    brightnessctl
    hyprlock
  ];

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
  home.file.".config/waybar/config".source = ./waybar.conf;
  home.file.".config/mako/config".source = ./mako.conf;
}
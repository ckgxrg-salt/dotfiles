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
    libsForQt5.polkit-kde-agent
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
  home.file.".config/waybar/config".source = ./waybar.conf;
  home.file.".config/mako/config".source = ./mako.conf;
}
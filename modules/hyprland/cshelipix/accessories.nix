{ config, pkgs, inputs, ... }:
# Extra programs for Hyprland
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
    nwg-drawer
  ];

  # Mako the Notification Daemon
  services.mako = {
    enable = true;
    anchor = "bottom-right";
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

  # UDiskie the Auto-Mount Manager
  services.udiskie = {
    enable = true;
    notify = true;
    tray = "auto";
    settings = {
      device_config = [
        {
          mount_path = "/var/lib/waydroid/rootfs";
          ignore = true;
        }
      ];
    };
  };

  services.cliphist = {
    enable = true;
  };

  # Config file
  home.file.".config/waypaper/config.ini".source = ./waypaper.ini;
}
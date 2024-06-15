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

    udiskie
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

  # UDiskie the Auto-Mount Manager, Home-manager has issues generating the config automatically, so guess can only do it manually.
  xdg.configFile."udiskie/config.yml".text = ''
    device_config:
    - device_file: /dev/loop0
      ignore: true
    program_options:
      automount: true
      notify: true
      tray: auto
  '';

  services.cliphist = {
    enable = true;
  };

  # Waypaper
  xdg.configFile."waypaper/config.ini".source = ./waypaper.ini;

  # Fusuma the touchscreen gesture recogniser
  services.fusuma = {
    enable = true;
    extraPackages = with pkgs; [
      ydotool
      coreutils
    ];
    settings = {
      threshold = {
        swipe = 0.5;
        pinch = 0.2;
      };
      interval = {
        swipe = 0.2;
        pinch = 0.2;
      };
      swipe = {
        "4" = {
          left.command = "pkill -USR1 waybar";
        };
      };
      pinch = {
        "3" = {
          "in".command = "hyprctl dispatch killactive";
        };
      };
    };
  };
}
{ pkgs, inputs, ... }:
# Extra programs for Hyprland
{
  imports = [ ./waybar.nix ./hypreco.nix ./wlogout.nix ];

  # Hyprland accessories
  home.packages = with pkgs; [
    waypaper
    swww
    udiskie
    blueberry
    networkmanagerapplet

    brightnessctl
    pamixer
    libnotify

    libsForQt5.polkit-kde-agent

    playerctl
    pwvucontrol

    nwg-drawer
    (pkgs.callPackage ../../../packages/wvkbd-desktop.nix { })
  ];

  # Mako the Notification Daemon
  services.mako = {
    enable = true;
    anchor = "bottom-right";
    borderRadius = 15;
    backgroundColor = "#8fbcbbdd";
    borderColor = "#4c566aee";
    defaultTimeout = 15000;
    font = "maple mono 12";
    height = 150;
    width = 450;
    icons = true;
    maxIconSize = 64;
    maxVisible = 3;
  };
  # Mako's icons
  xdg.configFile = {
    "mako/icons/brightness-20.png".source = ./assets/brightness-20.png;
    "mako/icons/brightness-40.png".source = ./assets/brightness-40.png;
    "mako/icons/brightness-60.png".source = ./assets/brightness-60.png;
    "mako/icons/brightness-80.png".source = ./assets/brightness-80.png;
    "mako/icons/brightness-100.png".source = ./assets/brightness-100.png;
    "mako/icons/volume-high.png".source = ./assets/volume-high.png;
    "mako/icons/volume-low.png".source = ./assets/volume-low.png;
    "mako/icons/volume-mid.png".source = ./assets/volume-mid.png;
    "mako/icons/volume-mute.png".source = ./assets/volume-mute.png;
  };

  # UDiskie the Auto-Mount Manager, sadly Nix is problematic dealing with order of options
  xdg.configFile."udiskie/config.yml".text = ''
    device_config:
    - device_file: /dev/loop0
      ignore: true
    program_options:
      automount: true
      notify: true
      tray: auto
  '';

  services.cliphist = { enable = true; };

  # Waypaper
  xdg.configFile."waypaper/config.ini".source = ./waypaper.ini;

  # Fusuma the touchscreen gesture recogniser
  services.fusuma = {
    enable = true;
    extraPackages = with pkgs; [ ydotool coreutils ];
    settings = {
      threshold = {
        swipe = 0.5;
        pinch = 0.2;
      };
      interval = {
        swipe = 0.2;
        pinch = 0.2;
      };
      swipe = { "4" = { left.command = "pkill -USR1 waybar"; }; };
      pinch = { "3" = { "in".command = "hyprctl dispatch killactive"; }; };
    };
  };

  # Redshift the color temperature adjuster
  services.redshift = {
    enable = true;
    longitude = 117.0702181;
    latitude = 36.6663163;
    tray = false;
    temperature = {
      day = 5000;
      night = 3200;
    };
    settings = {
      redshift = {
        fade = 1;
      };
    };
  };
}

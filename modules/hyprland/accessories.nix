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
  systemd.user.services.wlogout = {
    Unit = {
      Description = "WLogout Logout Screen";
      Requisite = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      Restart = "no";
      ExecStart = "${pkgs.wlogout}/bin/wlogout";
      ExecStopPost = "${pkgs.systemd}/bin/systemctl --user start unlock.target";
    };
    Install = {
      WantedBy = [ "lock.target" ];
    };
  };
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
        label = "suspend";
        action = "systemctl suspend";
        text = "Sleep";
        keybind = "p";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "End Session";
        keybind = "e";
      }
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock Screen";
        keybind = "l";
      }
    ];
    style = ''
      * {
	      background-image: none;
	      box-shadow: none;
      }
      button {
        border-radius: 60px;
        border-color: #d8dee9;
	      text-decoration-color: #FFFFFF;
        color: #FFFFFF;
	      border-style: solid;
	      border-width: 5px;
	      background-repeat: no-repeat;
	      background-position: center;
	      background-size: 25%;
      }
      #lock {
        background-color: #a3be8c;
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }
      #logout {
        background-color: #ebcb8b;
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }
      #suspend {
        background-color: #b48ead;
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
      }
      #hibernate {
        background-color: #5e81ac;
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
      }
      #shutdown {
        background-color: #bf616a;
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }
      #reboot {
        background-color: #d08770;
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }
      #lock:focus, #lock:active, #lock:hover,
      #logout:focus, #logout:active, #logout:hover,
      #suspend:focus, #suspend:active, #suspend:hover,
      #hibernate:focus, #hibernate:active, #hibernate:hover,
      #shutdown:focus, #shutdown:active, #shutdown:hover,
      #reboot:focus, #reboot:active, #reboot:hover {
	      background-color: #3700B3;
	      outline-style: none;
      }
    '';
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
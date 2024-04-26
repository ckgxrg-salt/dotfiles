{ config, pkgs, ... }:
{
  # Waybar the Wayland Bar
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "hyprland-session.target";
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        spacing = 6;
        modules-left = [ "image#launcher" "hyprland/workspaces" ];
        modules-center = [ "gamemode" ];
        modules-right = [ "mpris" "pulseaudio/slider" "network" "clock" "tray" ];

        "image#launcher" = {
          path = "${config.home.homeDirectory}/.config/waybar/icon.png";
          on-click = "rofi -show drun";
          tooltip = "Show Rofi Menu";
          size = 32;
        };
        "hyprland/workspaces" = {
          format = "{name}";
          format-window-separator = " | ";
          sort-by = "id";
        };
        "mpris" = {
	        format = "{player_icon} {title}";
	        format-paused = "{status_icon} <i>{title}</i>";
	        player-icons = {
		        default = "▶";
		        mpv = "🎵";
	        };
	        status-icons = {
		        paused = "⏸";
	        }; 
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };
        "network" = {
          format-wifi = "{essid}";
          format-ethernet = "Ethernet";
          format-linked = "Linked";
          format-disconnected = "Humourous Network";
        };
        "clock" = {
          format = "{:%H:%M}";
          interval = 60;
        };
        "tray" = {
          icon-size = 16;
          spacing = 10;
        };
      };
    };
  };

  # The Icon
  home.file.".config/waybar/icon.png".source = ./nixos.png;
}
{ config, ... }:
# Options for Waybar
{
  # Waybar the Wayland Bar
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 22;
      spacing = 0;
      modules-left = [
        "image#launcher"
        "hyprland/workspaces"
        "idle_inhibitor"
      ];
      modules-center = [ "gamemode" ];
      modules-right = [
        "mpris"
        "network"
        "pulseaudio/slider"
        "clock"
        "battery"
        "tray"
      ];

      "image#launcher" = {
        path = "${config.home.homeDirectory}/.config/waybar/icon.png";
        on-click = "rofi -show drun";
        tooltip = "Show Rofi Menu";
        size = 32;
      };
      "idle_inhibitor" = {
        format = "{icon}";
        tooltip-format-activated = "Inhibited Hypridle";
        tooltip-format-deactivated = "This widget says Zzz, pretending to be sleeping";
        format-icons = {
          activated = " No Idle";
          deactivated = "󰒲";
        };
      };
      "hyprland/workspaces" = {
        format = "{name}";
        format-window-separator = " | ";
        sort-by = "id";
      };
      "mpris" = {
        format = "{player_icon} {title}";
        format-paused = "{status_icon} <i>{title}</i>";
        title-len = 16;
        ellipsis = "...";
        on-click-right = "next";
        on-click-middle = "previous";
        player-icons = {
          default = "▶";
          elisa = "🎵";
        };
        status-icons.paused = "⏸";
      };
      "gamemode" = {
        glyph = "";
        hide-not-running = true;
        format = "{glyph} |Gamemode Active| {glyph}";
        format-alt = "{glyph} |Gamemode Active| {glyph}";
      };
      "battery" = {
        interval = 10;
        states = {
          "ful" = 100;
          "good" = 95;
          "warning" = 20;
          "critical" = 10;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}% | {time}  󱧥";
        format-plugged = "󰂄{capacity}% | {time}  󱧥";
        format-ful = "󱟢 Full";
        format-good = "{icon} {capacity}%";
        format-warning = "󰂃 {capacity}%";
        format-critical = "󱉞 {capacity}%";
        format-icons = [
          "󰁼"
          "󰁾"
          "󰁾"
          "󰂂"
          "󰂂"
        ];
      };
      "pulseaudio/slider" = {
        min = 0;
        max = 100;
        orientation = "horizontal";
      };
      "network" = {
        interval = 1;
        format-wifi = "  {essid} 󰕒 {bandwidthUpBytes} 󰇚 {bandwidthDownBytes}";
        format-ethernet = "󰈀  Connected";
        format-linked = "󰌷  Linked";
        format-disconnected = "󱛅  你不过关！";
      };
      "clock" = {
        format = "󰥔 {:%H:%M}";
        format-alt = "󰥔 {:%A, %B %d, %Y (%R)}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          format = {
            months = "<span color='#ffead3'><b>{}</b></span>";
            days = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
        };
        actions = {
          on-click-right = "mode";
          on-click-forward = "tz_up";
          on-click-backward = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };
      "tray" = {
        icon-size = 16;
        spacing = 10;
      };
    };
    style = ''
            * {
              font-family: Maple Mono;
              font-size: 18px;
              color: #d8dee9;
              min-height: 22px;
              opacity: 10;
            }
            window#waybar {
      	      background-color: rgba(17, 49, 79, 0.5);
            }
            #image.launcher {
              padding-left: 5px;
              padding-right: 5px;
              background-color: #7473af;
              border: solid;
              border-color: #2a292d;
              border-width: 2px;
            }
            #idle_inhibitor.deactivated {
              background-color: #7473af;
              border: solid;
              border-color: #2a292d;
              border-width: 2px;
              padding-left: 7px;
              padding-right: 7px;
            }
            #idle_inhibitor.activated {
              background-color: #7d605e;
              border: solid;
              border-color: #b35355;
              border-width: 5px;
              padding-left: 7px;
              padding-right: 7px;
            }
            #workspaces {
              background-color: #7473af;
              border: solid;
              border-color: #2a292d;
              border-width: 2px;
              padding-left: 0px;
              padding-right: 0px;
            }
            #workspaces button {
              min-width: 50px;
              border: none;
              border-radius: 0px;
              margin-left: 0px;
              margin-right: 0px;
              background-color: #46754e;
            }
            #workspaces button.active {
              border: none;
              background-color: #80af8c;
            }
            #gamemode.running {
              min-width: 72px;
              background-color: #b35355;
              border: dashed;
              border-color: #2a292d;
              border-width: 2px;
              padding-left: 5px;
              padding-right: 5px;
            }
            #mpris.stopped {
              min-width: 0px;
              min-height: 0px;
              border: none;
              padding: 0px 0px 0px 0px;
            }
            #mpris.playing {
              background-color: #80afbc;
              border: solid;
              border-color: #2a292d;
              border-width: 2px;
              padding-left: 5px;
              padding-right: 5px;
            }
            #mpris.paused {
              background-color: #46754e;
              border: solid;
              border-color: #2a292d;
              border-width: 2px;
              padding-left: 5px;
              padding-right: 5px;
            }
            #network {
              min-width: 72px;
              background-color: #7d605e;
              border: solid;
              border-color: #2a292d;
              border-width: 2px;
              padding-left: 5px;
              padding-right: 5px;
            }
            #clock {
              background-color: #7473af;
              border: solid;
              border-color: #2a292d;
              border-width: 2px;
              padding-left: 5px;
              padding-right: 5px;
            }
            #battery {
              background-color: #454074;
              border: solid;
              border-color: #2a292d;
              border-width: 2px;
              padding-left: 5px;
              padding-right: 5px;
            }
            #tray {
              padding-right: 0px;
              background-color: #2e4d31;
              border: solid;
              border-color: #2a292d;
              border-width: 2px;
              padding-left: 5px;
              padding-right: 5px;
            }
            #pulseaudio-slider {
              min-width: 96px;
              background-color: #454074;
              border: solid;
              border-color: #2a292d;
              border-width: 2px;
            }
            #pulseaudio-slider slider {
              min-height: 24px;
              min-width: 15px;
              border-radius: 0px;
              opacity: 50;
              border: solid;
            }
            #pulseaudio-slider trough {
              min-height: 20px;
              padding-left: 7px;
              padding-right: 7px;
              background-color: #80af8c;
            }
            #pulseaudio-slider highlight {
              margin-left: -7px;
              margin-right: -7px;
              background-color: #7473af;
            }
    '';
  };

  # The Icon
  home.file.".config/waybar/icon.png".source = ../../../assets/nixos.png;
}

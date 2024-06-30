{ config, ... }:
# Options for Waybar
{
  # Waybar the Wayland Bar
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "right";
        width = 20;
        spacing = 5;
        modules-left =
          [ "image#launcher" "idle_inhibitor" "hyprland/workspaces" ];
        modules-center = [ "gamemode" ];
        modules-right =
          [ "mpris" "network" "pulseaudio/slider" "clock" "battery" "tray" ];

        "image#launcher" = {
          path = "${config.home.homeDirectory}/.config/waybar/icon.png";
          on-click = "nwg-drawer";
          tooltip = "Show Application Drawer";
          size = 32;
        };
        "hyprland/workspaces" = {
          format = "{name}";
          format-window-separator = " | ";
          sort-by = "id";
        };
        "idle_inhibitor" = {
          format = "{icon}";
          tooltip-format-activated = "Inhibited Idle";
          tooltip-format-deactivated =
            "This widget says Zzz, pretending to be asleep";
          format-icons = {
            activated = "";
            deactivated = "󰒲";
          };
        };
        "mpris" = {
          format = "{player_icon}";
          format-paused = "{status_icon}";
          title-len = 16;
          ellipsis = "...";
          on-click-right = "next";
          on-click-middle = "previous";
          player-icons = {
            default = "▶";
            elisa = "🎵";
          };
          status-icons = { paused = "⏸"; };
        };
        "gamemode" = {
          glyph = "";
          hide-not-running = true;
          format = "";
          format-alt = "";
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
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄";
          format-ful = "󱟢 Full";
          format-good = "{icon} {capacity}%";
          format-warning = "󰂃 {capacity}%";
          format-critical = "󱉞 {capacity}%";
          format-icons = [ "󰁼" "󰁾" "󰁾" "󰂂" "󰂂" ];
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "vertical";
        };
        "network" = {
          interval = 1;
          format-wifi = "  =)";
          format-ethernet = "󰈀  =)";
          format-linked = "󰌷  =/";
          format-disconnected = "󱛅  =(";
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
    };
    style = ''
            * {
              font-family: Maple Mono;
              font-size: 14px;
              color: #2e3440;
              opacity: 10;
            }
            window#waybar {
      	      background-color: #2e3440;
            }
            tooltip {
              background-color: #8fbcbb;
            }
            tooltip label {
              color: #2e3440;
            }
            #image.launcher {
              padding-top: 5px;
              padding-bottom: 5px;
              background-color: #d8dee9;
              border: solid;
              border-radius: 10px;
              border-color: #81a1c1;
              border-width: 2px;
            }
            #idle_inhibitor.deactivated {
              background-color: #d8dee9;
              border: solid;
              border-color: #81a1c1;
              border-width: 2px;
              padding-top: 7px;
              padding-bottom: 7px;
            }
            #idle_inhibitor.activated {
              background-color: #8fbcbb;
              border: solid;
              border-color: #81a1c1;
              border-width: 5px;
              padding-top: 7px;
              padding-bottom: 7px;
            }
            #workspaces button {
              min-height: 30px;
              background-color: #d8dee9;
              border: solid;
              border-radius: 10px;
              border-color: #81a1c1;
              border-width: 2px;
            }
            #workspaces button.active {
              border: none;
              background-color: #81a1c1;
            }
            #gamemode.running {
              min-height: 60px;
              background-color: #d08770;
              border: dashed;
              border-radius: 10px;
              border-color: #bf616a;
              border-width: 2px;
              padding-top: 5px;
              padding-bottom: 5px;
            }
            #mpris.stopped {
              min-width: 0px;
              min-height: 0px;
              border: none;
              padding: 0px 0px 0px 0px;
            }
            #mpris.playing {
              background-color: #81a1c1;
              border: solid;
              border-radius: 15px;
              border-color: #81a1c1;
              border-width: 2px;
              padding-top: 5px;
              padding-bottom: 5px;
            }
            #mpris.paused {
              background-color: #5e81ac;
              border: solid;
              border-radius: 15px;
              border-color: #81a1c1;
              border-width: 2px;
              padding-top: 5px;
              padding-bottom: 5px;
            }
            #network {
              background-color: #d8dee9;
              border: solid;
              border-radius: 15px;
              border-color: #81a1c1;
              border-width: 2px;
              padding-top: 5px;
              padding-bottom: 5px;
            }
            #clock {
              background-color: #d8dee9;
              border: solid;
              border-radius: 15px;
              border-color: #81a1c1;
              border-width: 2px;
              padding-top: 5px;
              padding-bottom: 5px;
            }
            #battery {
              background-color: #eceff4;
              border: solid;
              border-radius: 15px;
              border-color: #81a1c1;
              border-width: 2px;
              padding-top: 5px;
              padding-bottom: 5px;
            }
            #tray {
              padding-bottom: 0px;
              background-color: #d8dee9;
              border: solid;
              border-radius: 15px;
              border-color: #81a1c1;
              border-width: 2px;
              padding-top: 5px;
              padding-bottom: 5px;
            }
            #tray menu {
              background-color: #81a1c1;
            }
            #pulseaudio-slider {
              min-height: 96px;
              background-color: #eceff4;
              border: solid;
              border-radius: 15px;
              border-color: #81a1c1;
              border-width: 2px;
            }
            #pulseaudio-slider slider {
              min-width: 15px;
              opacity: 50;
              border: solid;
              border-radius: 5px;
              border-color: #81a1c1;
            }
            #pulseaudio-slider trough {
              min-height: 70px;
              min-width: 12px;
              padding-top: 7px;
              padding-bottom: 7px;
              border-radius: 5px;
              background-color: #5e81ac;
            }
            #pulseaudio-slider highlight {
              border-radius: 5px;
              border-color: #81a1c1;
              margin-top: -7px;
              margin-bottom: -7px;
              background-color: #8fbcbb;
            }
    '';
  };

  # The Icon
  home.file.".config/waybar/icon.png".source = ./assets/nixos.png;
}

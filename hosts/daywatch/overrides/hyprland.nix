{ pkgs, ... }:
{
  wayland.windowManager.hyprland =
    let
      scripts = import ./scripts.nix { inherit pkgs; };
    in
    {
      plugins = with pkgs.hyprlandPlugins; [
        hyprgrass
        hyprscroller
        hypr-dynamic-cursors
      ];
      settings = {
        monitor = [
          "eDP-1, highres, 0x0, 1"
          "DP-1, highres, 0x1080, 1"
        ];
        windowrulev2 = [
          # Dialogs
          "float, class:(polkit-gnome-authentication-agent-1)"
          "center, class:(polkit-gnome-authentication-agent-1)"
          "stayfocused, class:(polkit-gnome-authentication-agent-1)"
          "size 50% 40%, class:(polkit-gnome-authentication-agent-1)"
          "float, class:(xdg-desktop-portal-gtk)"

          # cava
          "monitor DP-1, class:(alacritty-cava)"
          "opacity 0.6, class:(alacritty-cava)"
          "float, class:(alacritty-cava)"
          "size 1920 500, class:(alacritty-cava)"
          "move 0 30, class:(alacritty-cava)"

          # Some special windows should ignore hyprscroller
          "plugin:scroller:columnwidth one, class:(floorp)"
          "plugin:scroller:windowheight one, class:(floorp)"
        ];
        layerrule = [
          "noanim, swww-daemon"
          "animation slide right, notifications"
          "blur, astal-logout"
          "animation fade, astal-logout"
          "blur, astal-logout-cover"
          "animation fade, astal-logout-cover"
        ];
        workspace = [
          "special:browser, on-created-empty:floorp"
          "name:Dashboard, monitor:DP-1, persistent:true, default:true"
        ];

        general = {
          gaps_in = 16;
          gaps_out = 24;
          border_size = 8;
          layout = "scroller";
        };
        decoration = {
          blur = {
            enabled = true;
            size = 10;
            passes = 3;
            brightness = 1.1;
            vibrancy = 0.1;
            xray = true;
          };
          shadow = {
            enabled = true;
            range = 16;
            offset = "16 16";
          };
          rounding = 12;
          active_opacity = 0.75;
          inactive_opacity = 0.6;
        };
        animations = {
          enabled = true;
          bezier = [
            "easeInOutCubic, 0.645, 0.045, 0.355, 1"
            "easeInSine, 0.12, 0, 0.39, 0"
            "easeOutSine, 0.39, 0.575, 0.565, 1"
            "easeInOutSine, 0.37, 0, 0.63, 1"
          ];
          animation = [
            "windowsIn, 1, 2, easeInSine, slide"
            "windowsMove, 1, 2, easeInOutSine, slide"
            "windowsOut, 1, 3, easeOutSine, slide"
            "layersIn, 1, 2, easeInSine, slide right"
            "layersOut, 1, 3, easeOutSine, slide left"
            "fade, 1, 3, default"
            "workspaces, 1, 4, easeInOutCubic, slidefadevert"
            "specialWorkspace, 1, 4, easeInOutCubic, slide"
          ];
        };

        plugin = {
          touch_gestures = {
            sensitivity = 2.0;
            workspace_swipe_fingers = 0;
            workspace_swipe_edge = false;
            resize_on_border_long_press = true;
          };
          scroller = {
            column_widths = "onethird twothirds one";
            column_default_width = "twothirds";
            window_heights = "twothirds one";
            window_default_height = "one";
            cyclesize_wrap = false;
            focus_wrap = false;
            monitor_options = "(DP-1 = (column_default_width = one))";

            gesture_scroll_enable = true;
            gesture_scroll_fingers = 3;
            gesture_scroll_distance = 75;
            gesture_workspace_switch_enable = false;
          };
          dynamic-cursors = {
            enabled = true;
            mode = "stretch";
            threshold = 5;
            stretch = {
              limit = 10000;
              function = "linear";
            };
            shake = {
              enabled = false;
            };
          };
        };

        hyprgrass-bind = [
          ", edge:r:l, togglespecialworkspace, browser"
          ", swipe:4:ld, exec, astal-logout"
          ", swipe:3:l, scroller:movefocus, r"
          ", swipe:3:r, scroller:movefocus, l"
          ", swipe:3:u, scroller:movefocus, d"
          ", swipe:3:d, scroller:movefocus, u"
          ", swipe:3:ld, scroller:admitwindow,"
          ", swipe:3:ru, scroller:expelwindow,"
        ];
        hyprgrass-bindm = [
          ", longpress:2, movewindow"
          ", longpress:3, resizewindow"
        ];
        bind = [
          # Basics
          "SUPER, Q, exec, alacritty"
          "SUPER, C, killactive,"
          "SUPER, V, togglefloating,"
          "SUPER, R, exec, rofi -show drun"
          "SUPER, F, fullscreen,"
          "SUPER, Tab, scroller:toggleoverview,"
          "SUPER, Print, exec, grimblast copy area"
          ", XF86PowerOff, exec, astal-logout"
          "CTRL ALT, C, exec, ${scripts.clipboard}"

          # Volume and brightness controls
          ", XF86AudioMute, exec, ${scripts.volume} --toggle"
          ", XF86AudioLowerVolume, exec, ${scripts.volume} --dec"
          ", XF86AudioRaiseVolume, exec, ${scripts.volume} --inc"
          ", XF86MonBrightnessUp, exec, ${scripts.brightness} --inc"
          ", XF86MonBrightnessDown, exec, ${scripts.brightness} --dec"

          # Move focus
          "SUPER, J, scroller:movefocus, d"
          "SUPER, K, scroller:movefocus, u"
          "SUPER, H, scroller:movefocus, l"
          "SUPER, L, scroller:movefocus, r"
          "SUPER SHIFT, J, scroller:movewindow, d"
          "SUPER SHIFT, K, scroller:movewindow, u"
          "SUPER SHIFT, H, scroller:movewindow, l"
          "SUPER SHIFT, L, scroller:movewindow, r"
          "SUPER CTRL, H, scroller:admitwindow,"
          "SUPER CTRL, L, scroller:expelwindow,"

          # Adjust windows
          "SUPER, mouse_up, scroller:cyclewidth, prev"
          "SUPER, mouse_down, scroller:cyclewidth, next"
          "SUPER SHIFT, mouse_up, scroller:cycleheight, prev"
          "SUPER SHIFT, mouse_down, scroller:cycleheight, next"
          "SUPER, minus, scroller:cyclesize, prev"
          "SUPER, equal, scroller:cyclesize, next"
          "SUPER, F11, scroller:pin,"

          # Switch hyprscroller modes
          "SUPER, F9, exec, ${scripts.scroller} --toggle"

          # Special Workspaces
          "SUPER, S, togglespecialworkspace, browser"
          "SUPER SHIFT, W, workspace, name:"
          "SUPER, D, workspace, name:Dashboard"
          "SUPER SHIFT, S, movetoworkspace, special:browser"
          "SUPER SHIFT, D, movetoworkspace, name:Dashboard"
          # Ordinary workspaces
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
        ];
      };
      # Hardware(Touchscreen & Tablet)
      extraConfig = ''
        device {
          name = elan9008:00-04f3:2d55
          output = eDP-1
        }
        device {
          name = elan9009:00-04f3:2c1b
          output = DP-1
        }
        device {
          name = elan9008:00-04f3:2d55-stylus
          output = eDP-1
        }
        device {
          name = elan9009:00-04f3:2c1b-stylus
          output = DP-1
        }
      '';
    };
}

{ pkgs, ... }:
# Hyprland the Wayland compositor
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    xwayland.enable = true;
    plugins = with pkgs.hyprlandPlugins; [
      hyprgrass
      hyprscroller
    ];
    settings = {
      # Hardware
      monitor = [
        "eDP-1, highres, 0x0, 1"
      ];
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
          tap-and-drag = true;
        };
        sensitivity = 0;
      };
      binds = {
        scroll_event_delay = 20;
      };

      # Initialisation
      exec-once = [
        "canberra-gtk-play -i desktop-login"
      ];

      # Window, workspace and layer rules
      windowrulev2 = [
        # Dialogs
        "float, class:(polkit-kde-authentication-agent-1)"
        "center, class:(polkit-kde-authentication-agent-1)"
        "stayfocused, class:(polkit-kde-authentication-agent-1)"
        "size 50% 40%, class:(polkit-kde-authentication-agent-1)"
        "float, class:(xdg-desktop-portal-gtk)"

        # Open Waydroid in a dedicated workspace
        "workspace name: silent, class:(Waydroid)"
        "fullscreen, class:(Waydroid)"

        # Some special windows should ignore hyprscroller
        "plugin:scroller:columnwidth one, class:(org.qutebrowser.qutebrowser)"
        "plugin:scroller:windowheight one, class:(org.qutebrowser.qutebrowser)"

        # Wrap C.A.V.A. the background audio visualiser
        "workspace name:Dashboard silent, class:(alacritty-cava)"
        "noanim, class:(alacritty-cava)"
        "nodim, class:(alacritty-cava)"
        "noblur, class:(alacritty-cava)"
        "nofocus, class:(alacritty-cava)"
        "float, class:(alacritty-cava)"
        "size 1920 515, class:(alacritty-cava)"
        "plugin:scroller:columnwidth one, class:(alacritty-cava)"
        "plugin:scroller:windowheight one, class:(alacritty-cava)"
      ];
      layerrule = [
        "noanim, swww-daemon"
        "animation slide right, notifications"
      ];
      workspace = [
        "special:browser, on-created-empty:uwsm app -- qutebrowser"
      ];

      # Options
      general = {
        gaps_in = 10;
        gaps_out = 0;
        border_size = 8;
        "col.active_border" = "rgba(A7C08044)";
        "col.inactive_border" = "rgba(42504799)";
        layout = "scroller";
        allow_tearing = false;
        resize_on_border = true;
        snap = {
          enabled = true;
        };
      };
      gestures = {
        workspace_swipe = false;
        workspace_swipe_touch = false;
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        new_window_takes_over_fullscreen = 2;
        disable_hyprland_qtutils_check = true;
      };
      xwayland = {
        force_zero_scaling = true;
      };

      # Somehow "fancy" effects
      decoration = {
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
          vibrancy = 0.2;
          brightness = 1.5;
          contrast = 1.2;
        };
        shadow = {
          enabled = true;
          range = 6;
          render_power = 3;
          color = "rgba(1C1C1CEE)";
        };
        rounding = 0;
        dim_inactive = true;
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

      # Plugins Config
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

          # Gestures
          gesture_scroll_enable = true;
          gesture_scroll_fingers = 3;
          gesture_scroll_distance = 75;
          gesture_workspace_switch_enable = false;
        };
      };

      # Touchscreen binds
      hyprgrass-bind = [
        ", edge:r:l, togglespecialworkspace, browser"
        ", edge:d:u, exec, pkill -RTMIN wvkbd-desktop"
        ", swipe:4:ld, exec, uwsm app -- wlogout"
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
      # Binds
      bind = [
        # Basics
        "SUPER, Q, exec, uwsm app -- alacritty"
        "SUPER, C, killactive,"
        "SUPER, V, togglefloating,"
        "SUPER, R, exec, uwsm app -- rofi -show drun"
        "SUPER, F, fullscreen,"
        "SUPER, Tab, scroller:toggleoverview,"
        "SUPER, Print, exec, uwsm app -- grimblast copy area"
        ", XF86PowerOff, exec, uwsm app -- wlogout"

        # Volume and brightness controls
        ", XF86AudioMute, exec, volume --toggle"
        ", XF86AudioLowerVolume, exec, volume --dec"
        ", XF86AudioRaiseVolume, exec, volume --inc"
        ", XF86MonBrightnessUp, exec, brightness --inc"
        ", XF86MonBrightnessDown, exec, brightness --dec"

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
        "SUPER, F9, exec, scrollermod --toggle"

        # Special Workspaces
        "SUPER, S, togglespecialworkspace, browser"
        "SUPER SHIFT, W, workspace, name:"
        "SUPER SHIFT, S, movetoworkspace, special:browser"
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

      # Move, resize and scroller mode
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}

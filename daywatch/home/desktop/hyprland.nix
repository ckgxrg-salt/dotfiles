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
        "DP-1, highres, 0x1080, 1"
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
        "canberra-gtk-play -i desktop-login -d \"welcome\""
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

        # Wrap C.A.V.A. as the background audio visualiser
        "workspace name:dashboard silent, class:(alacritty-cava)"
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
        "name:dashboard, monitor:DP-1, persistent:true, default:true, gapsin:0, gapsout:0, shadow:false, rounding:false, border:false"
      ];

      # Options
      general = {
        gaps_in = 10;
        gaps_out = 18;
        border_size = 0;
        "col.active_border" = "rgba(00000000)";
        "col.inactive_border" = "rgba(00000000)";
        layout = "scroller";
        allow_tearing = false;
        resize_on_border = true;
        snap = {
          enabled = true;
        };
      };
      dwindle = {
        smart_split = true;
        smart_resizing = true;
      };
      cursor = {
        no_hardware_cursors = true;
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
          size = 2;
          passes = 3;
          vibrancy = 0.1696;
        };
        shadow = {
          enabled = true;
          range = 6;
          render_power = 3;
          color = "rgba(1c1c1cee)";
        };
        rounding = 18;
        active_opacity = 0.9;
        inactive_opacity = 0.8;
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
        };
        scroller = {
          column_widths = "onethird onehalf twothirds one";
          column_default_width = "onethird";
          window_heights = "onethird twothirds one";
          window_default_height = "one";
          cyclesize_wrap = 0;
          focus_wrap = 0;
          monitor_options = "(DP-1 = (column_default_width = one))";
        };
      };

      # Touchscreen binds
      hyprgrass-bind = [
        ", swipe:4:l, togglespecialworkspace, browser"
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
        "SUPER, E, exec, uwsm app -- index"
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
        # Adjust windows
        "SUPER, mouse_up, scroller:cyclewidth, prev"
        "SUPER, mouse_down, scroller:cyclewidth, next"
        "SUPER SHIFT, mouse_up, scroller:cycleheight, prev"
        "SUPER SHIFT, mouse_down, scroller:cycleheight, next"
        "SUPER, minus, scroller:cyclewidth, prev"
        "SUPER, equal, scroller:cyclewidth, next"
        "SUPER SHIFT, minus, scroller:cycleheight, prev"
        "SUPER SHIFT, equals, scroller:cycleheight, next"
        "SUPER, F11, scroller:pin,"
        "SUPER, bracketleft, scroller:admitwindow,"
        "SUPER, bracketright, scroller:expelwindow,"
        # Scroller modes
        "SUPER, F12, scroller:setmode, row"
        "SUPER SHIFT, F12, scroller:setmode, col"
        # Special workspaces
        "SUPER, S, togglespecialworkspace, browser"
        "SUPER SHIFT, W, workspace, name:"
        "SUPER, P, workspace, name:dashboard"
        "SUPER SHIFT, S, movetoworkspace, special:browser"
        "SUPER SHIFT, P, movetoworkspace, name:dashboard"

        # Sound effects
        "SUPER, S, exec, canberra-gtk-play -i message-highlight -d \"openBrowser\""
        "SUPER SHIFT, W, exec, canberra-gtk-play -i service-login -d \"openWaydroid\""
        "SUPER, Print, exec, canberra-gtk-play -i dialog-question -d \"screenshot\""
        ", XF86PowerOff, exec, canberra-gtk-play -i service-logout -d \"wlogout\""
        "SUPER, V, exec, canberra-gtk-play -i outcome-success -d \"floating\""
        "SUPER, F, exec, canberra-gtk-play -i outcome-success -d \"fullscreen\""
        "SUPER, C, exec, canberra-gtk-play -i outcome-failure -d \"close\""
      ];
      # Move, resize and scroller mode
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
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

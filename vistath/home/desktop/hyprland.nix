{ pkgs, ckgs, ... }:
# Hyprland the Wayland compositor
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    xwayland.enable = true;
    plugins = with pkgs.hyprlandPlugins; [
      hyprgrass
      hy3
      ckgs.show-my-osk
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
      ];
      layerrule = [
        "noanim, swww-daemon"
        "animation slide right, notifications"
        "blur, astal-quickcontrol"
        "animation fade, astal-quickcontrol"
        "animation slide down, astal-navigator"
      ];
      workspace = [
        "special:browser, on-created-empty:uwsm app -- floorp"
      ];

      # Options
      general = {
        gaps_in = 10;
        gaps_out = 0;
        border_size = 0;
        layout = "hy3";
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
          range = 8;
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
        hy3 = {
          no_gaps_when_only = 1;
          autotile = {
            enable = true;
          };
        };
        showmyosk = {
          on_focus = "exec pkill -USR2 wvkbd-vistath";
          on_leave = "exec pkill -USR1 wvkbd-vistath";
        };
      };

      # Touchscreen binds
      hyprgrass-bind = [
        ", edge:d:u, exec, vistath-astal navigator"
        ", edge:u:d, exec, vistath-astal quickcontrol"
        ", swipe:3:u, exec, pkill -RTMIN wvkbd-vistath"
        ", edge:r:l, togglespecialworkspace, browser"
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
        "SUPER, Print, exec, uwsm app -- grimblast copy area"
        ", XF86PowerOff, exec, uwsm app -- astal-logout"

        # Volume and brightness controls
        ", XF86AudioMute, exec, volume --toggle"
        ", XF86AudioLowerVolume, exec, volume --dec"
        ", XF86AudioRaiseVolume, exec, volume --inc"
        ", XF86MonBrightnessUp, exec, brightness --inc"
        ", XF86MonBrightnessDown, exec, brightness --dec"

        # Move focus
        "SUPER, J, hy3:movefocus, d"
        "SUPER, K, hy3:movefocus, u"
        "SUPER, H, hy3:movefocus, l"
        "SUPER, L, hy3:movefocus, r"
        "SUPER SHIFT, J, hy3:movewindow, d"
        "SUPER SHIFT, K, hy3:movewindow, u"
        "SUPER SHIFT, H, hy3:movewindow, l"
        "SUPER SHIFT, L, hy3:movewindow, r"

        # Special Workspaces
        "SUPER SHIFT, W, workspace, name:"
        "SUPER, S, togglespecialworkspace, browser"
        "SUPER SHIFT, S, movetoworkspace, special:browser"
        # Ordinary workspaces
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
      ];

      # Move, resize and scroller mode
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}

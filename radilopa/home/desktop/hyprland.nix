{ ... }:
# Hyprland Window Manager
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    xwayland.enable = true;
    settings = {
      # Hardware
      monitor = [ ",highres, auto, 1.25" ];
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
        sensitivity = 0;
      };

      # Initialisation
      exec-once = [
        "canberra-gtk-play -i desktop-login -d \"welcome\""
      ];

      # Window and workspace rules
      windowrulev2 = [
        "float,class:(org.kde.polkit-kde-authentication-agent-1)"
        "float,class:(bilibili),initialTitle:(undefined)"
        "float, class:(xdg-desktop-portal-gtk)"
        "float, class:(QQ)"
        "center, class:(QQ)"
      ];
      workspace = [ "special:browser, on-created-empty:uwsm app -- qutebrowser" ];

      # Some options
      general = {
        gaps_in = 20;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(80af8cee) rgba(7473afee) 45deg";
        "col.inactive_border" = "rgba(4a4949aa)";
        layout = "dwindle";
        allow_tearing = false;
        resize_on_border = true;
      };
      cursor = {
        no_hardware_cursors = true;
      };
      dwindle = {
        smart_split = true;
        smart_resizing = true;
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_min_fingers = true;
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

      # Fancy effects
      decoration = {
        blur = {
          enabled = true;
          size = 6;
          passes = 1;
          vibrancy = 0.1696;
        };
        shadow.enabled = false;
        dim_inactive = true;
      };
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Binds
      bind = [
        "SUPER, Q, exec, alacritty"
        "SUPER, C, killactive,"
        "SUPER SHIFT, Escape, exec, wlogout"
        "SUPER, V, togglefloating,"
        "SUPER, R, exec, rofi -show drun"
        "SUPER, J, togglesplit,"
        "SUPER, L, exec, hyprlock --immediate"
        "SUPER, F, fullscreen,"
        "SUPER, Print, exec, grimblast copy area"
        ", XF86PowerOff, exec, uwsm app -- wlogout"
        # Volume and brightness controls
        ", XF86AudioMute, exec, volume --toggle"
        ", XF86AudioLowerVolume, exec, volume --dec"
        ", XF86AudioRaiseVolume, exec, volume --inc"
        ", XF86MonBrightnessUp, exec, brightness --inc"
        ", XF86MonBrightnessDown, exec, brightness --dec"
        # Move focus with mainMod + arrow keys
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        # Switch workspaces with mainMod + [0-9]
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
        # Example special workspace (scratchpad)
        "SUPER, S, togglespecialworkspace, browser"
        "SUPER SHIFT, S, movetoworkspace, special:browser"
        # Scroll through existing workspaces with mainMod + scroll
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
      ];
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };
}

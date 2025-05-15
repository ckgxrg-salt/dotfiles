{ pkgs, ckgs, ... }:
{
  wayland.windowManager.hyprland =
    let
      scripts = import ./scripts.nix { inherit pkgs; };
    in
    {
      plugins = with pkgs.hyprlandPlugins; [
        hyprgrass
        ckgs.show-my-osk
      ];
      settings = {
        monitor = [
          "eDP-1, highres, 0x0, 1"
        ];
        windowrulev2 = [
          # Dialogs
          "float, class:(polkit-gnome-authentication-agent-1)"
          "center, class:(polkit-gnome-authentication-agent-1)"
          "stayfocused, class:(polkit-gnome-authentication-agent-1)"
          "size 50% 40%, class:(polkit-gnome-authentication-agent-1)"
          "float, class:(xdg-desktop-portal-gtk)"

          # cava
          "monitor eDP-1, class:(alacritty-cava)"
          "opacity 0.6, class:(alacritty-cava)"
          "float, class:(alacritty-cava)"
          "size 1920 500, class:(alacritty-cava)"
          "move 0 30, class:(alacritty-cava)"

          # Open Waydroid in a dedicated workspace
          "workspace name: silent, class:(Waydroid)"
          "fullscreen, class:(Waydroid)"
        ];
        layerrule = [
          "noanim, swww-daemon"
          "animation slide right, notifications"
          "blur, astal-quickcontrol"
          "animation fade, astal-quickcontrol"
          "animation fade, astal-logout"
          "animation slide bottom, astal-navigator"
        ];
        workspace = [
          "special:browser, on-created-empty:uwsm app -- floorp"
        ];

        general = {
          gaps_in = 10;
          gaps_out = 0;
          border_size = 0;
          layout = "master";
        };
        decoration = {
          blur = {
            enabled = true;
            size = 8;
            passes = 2;
            brightness = 1.5;
            vibrancy = 0.2;
            contrast = 1.2;
            xray = true;
          };
          shadow = {
            enabled = true;
            range = 8;
            offset = "8 8";
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

        plugin = {
          touch_gestures = {
            sensitivity = 2.0;
            workspace_swipe_fingers = 0;
            workspace_swipe_edge = false;
            resize_on_border_long_press = true;
          };
          showmyosk = {
            on_focus = "exec pkill -USR2 wvkbd-vistath";
            on_leave = "exec pkill -USR1 wvkbd-vistath";
          };
        };

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
        bind = [
          # Basics
          "SUPER, Q, exec, uwsm app -- alacritty"
          "SUPER, C, killactive,"
          "SUPER, V, togglefloating,"
          "SUPER, R, exec, uwsm app -- rofi -show drun"
          "SUPER, F, fullscreen,"
          "SUPER, Print, exec, uwsm app -- grimblast copy area"
          ", XF86PowerOff, exec, uwsm app -- astal-logout"
          "CTRL ALT, C, exec, ${scripts.clipboard}"

          # Volume and brightness controls
          ", XF86AudioMute, exec, ${scripts.volume} --toggle"
          ", XF86AudioLowerVolume, exec, ${scripts.volume} --dec"
          ", XF86AudioRaiseVolume, exec, ${scripts.volume} --inc"
          ", XF86MonBrightnessUp, exec, ${scripts.brightness} --inc"
          ", XF86MonBrightnessDown, exec, ${scripts.brightness} --dec"

          # Move focus
          "SUPER, J, movefocus, d"
          "SUPER, K, movefocus, u"
          "SUPER, H, movefocus, l"
          "SUPER, L, movefocus, r"
          "SUPER SHIFT, J, movewindow, d"
          "SUPER SHIFT, K, movewindow, u"
          "SUPER SHIFT, H, movewindow, l"
          "SUPER SHIFT, L, movewindow, r"

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
      };
    };
}

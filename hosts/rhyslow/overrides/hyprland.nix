{ pkgs, ... }:
{
  wayland.windowManager.hyprland =
    let
      scripts = import ./scripts.nix { inherit pkgs; };
    in
    {
      plugins = with pkgs.hyprlandPlugins; [
        hypr-dynamic-cursors
      ];
      settings = {
        monitor = [ ",highres, 0x0, 1" ];
        windowrulev2 = [
          # Dialogs
          "float, class:(polkit-gnome-authentication-agent-1)"
          "center, class:(polkit-gnome-authentication-agent-1)"
          "stayfocused, class:(polkit-gnome-authentication-agent-1)"
          "size 50% 40%, class:(polkit-gnome-authentication-agent-1)"
          "float, class:(xdg-desktop-portal-gtk)"
        ];
        workspace = [
          "special:browser, on-created-empty:floorp"
        ];

        general = {
          gaps_in = 20;
          gaps_out = 20;
          border_size = 2;
          layout = "dwindle";
        };
        decoration = {
          blur = {
            enabled = true;
            size = 6;
            passes = 1;
            vibrancy = 0.1696;
          };
          shadow = {
            enabled = false;
          };
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

        bind = [
          # Basics
          "SUPER, Q, exec, alacritty"
          "SUPER, C, killactive,"
          "SUPER, V, togglefloating,"
          "SUPER, R, exec, rofi -show drun"
          "SUPER, F, fullscreen,"
          "SUPER, Print, exec, grimblast copy area"
          "SUPER SHIFT, Print, exec, hyprpicker --autocopy --quiet"
          ", XF86PowerOff, exec, wlogout"
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

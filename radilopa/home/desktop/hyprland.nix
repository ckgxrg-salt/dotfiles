{ pkgs, ... }:
# Hyprland Window Manager
{
  wayland.windowManager.hyprland =
    let
      # Thanks for the ArchWiki for this awesome script
      volumeScript = pkgs.writeShellScript "mako-volume-script" ''
                    iDIR="$HOME/.config/mako/icons"
                    get_volume() {
        	            volume=$(pamixer --get-volume)
        	            echo "$volume"
                    }
                    get_icon() {
        	            current=$(get_volume)
        	            if [[ "$current" -eq "0" ]]; then
        		            echo "$iDIR/volume-mute.png"
        	            elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
        		            echo "$iDIR/volume-low.png"
        	            elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
        		            echo "$iDIR/volume-mid.png"
        	            elif [[ ("$current" -ge "60") && ("$current" -le "100") ]]; then
        		            echo "$iDIR/volume-high.png"
        	            fi
                    }
                    notify_user() {
        	            notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Volume : $(get_volume) %"
                      canberra-gtk-play -i audio-volume-change -d "changeVolume"
                    }
                    inc_volume() {
        	            wpctl set-volume @DEFAULT_SINK@ 0.05+ && notify_user
                    }
                    dec_volume() {
        	            wpctl set-volume @DEFAULT_SINK@ 0.05- && notify_user
                    }
                    toggle_mute() {
        	            if [ "$(pamixer --get-mute)" == "false" ]; then
        		            wpctl set-mute @DEFAULT_SINK@ 1 && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/volume-mute.png" "Muted"
        	            elif [ "$(pamixer --get-mute)" == "true" ]; then
        		            wpctl set-mute @DEFAULT_SINK@ 0 && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Unmuted"
        	            fi
                    }
                    if [[ "$1" == "--get" ]]; then
        	            get_volume
                    elif [[ "$1" == "--inc" ]]; then
        	            inc_volume
                    elif [[ "$1" == "--dec" ]]; then
        	            dec_volume
                    elif [[ "$1" == "--toggle" ]]; then
        	            toggle_mute
                    elif [[ "$1" == "--get-icon" ]]; then
        	            get_icon
                    else
        	            get_volume
                    fi
      '';

      brightnessScript = pkgs.writeShellScript "mako-brightness-script" ''
                    iDIR="$HOME/.config/mako/icons"
                    get_backlight() {
        	            LIGHT=$(printf "%.0f\n" $(brightnessctl get))
        	            echo $(expr $LIGHT / 960)
                    }
                    get_icon() {
        	            current="$(get_backlight)"
        	            if [[ ("$current" -ge "0") && ("$current" -le "20") ]]; then
        		            icon="$iDIR/brightness-20.png"
        	            elif [[ ("$current" -ge "20") && ("$current" -le "40") ]]; then
        		            icon="$iDIR/brightness-40.png"
        	            elif [[ ("$current" -ge "40") && ("$current" -le "60") ]]; then
        		            icon="$iDIR/brightness-60.png"
        	            elif [[ ("$current" -ge "60") && ("$current" -le "80") ]]; then
        		            icon="$iDIR/brightness-80.png"
        	            elif [[ ("$current" -ge "80") && ("$current" -le "100") ]]; then
        		            icon="$iDIR/brightness-100.png"
        	            fi
                    }
                    notify_user() {
        	            notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Brightness : $(get_backlight)%"
                      canberra-gtk-play -i audio-volume-change -d "changeBrightness"
                    }
                    inc_backlight() {
        	            brightnessctl set 5%+ && get_icon && notify_user
                    }
                    dec_backlight() {
        	            brightnessctl set 5%- && get_icon && notify_user
                    }
                    if [[ "$1" == "--get" ]]; then
        	            get_backlight
                    elif [[ "$1" == "--inc" ]]; then
        	            inc_backlight
                    elif [[ "$1" == "--dec" ]]; then
        	            dec_backlight
                    else
        	            get_backlight
                    fi
      '';
    in
    {
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
          "SUPER, E, exec, dolphin"
          "SUPER, V, togglefloating,"
          "SUPER, R, exec, rofi -show drun"
          "SUPER, J, togglesplit,"
          "SUPER, L, exec, hyprlock --immediate"
          "SUPER, F, fullscreen,"
          "SUPER, Print, exec, grimblast copy area"
          ", XF86PowerOff, exec, uwsm app -- wlogout"
          # Volume and brightness controls
          ", XF86AudioMute, exec, ${volumeScript} --toggle"
          ", XF86AudioLowerVolume, exec, ${volumeScript} --dec"
          ", XF86AudioRaiseVolume, exec, ${volumeScript} --inc"
          ", XF86MonBrightnessUp, exec, ${brightnessScript} --inc"
          ", XF86MonBrightnessDown, exec, ${brightnessScript} --dec"
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

{ pkgs, ... }:
# Hyprland the Wayland compositor
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
        	            LIGHT=$(printf "%.0f\n" $(brightnessctl get --device=intel_backlight))
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
        	            brightnessctl --device=intel_backlight set 5%+ & brightnessctl --device=asus_screenpad set 5%+ && get_icon && notify_user
                    }
                    dec_backlight() {
        	            brightnessctl --device=intel_backlight set 5%- & brightnessctl --device=asus_screenpad set 5%- && get_icon && notify_user
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
      plugins = with pkgs.hyprlandPlugins; [
        hyprgrass
        hyprspace
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

          # Wrap C.A.V.A. as the background audio visualiser
          "workspace name:dashboard silent, class:(alacritty-cava)"
          "noanim, class:(alacritty-cava)"
          "nodim, class:(alacritty-cava)"
          "noblur, class:(alacritty-cava)"
          "nofocus, class:(alacritty-cava)"
          "float, class:(alacritty-cava)"
          "size 1920 515, class:(alacritty-cava)"
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
          layout = "dwindle";
          allow_tearing = false;
          resize_on_border = true;
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
        cursor = {
          no_hardware_cursors = true;
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          new_window_takes_over_fullscreen = 2;
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
            workspace_swipe_fingers = 4;
            workspace_swipe_edge = "no";
          };
        };

        # Touchscreen binds
        hyprgrass-bind = [
          ",swipe:4:l, togglespecialworkspace, browser"
        ];
        hyprgrass-bindm = [
          ",longpress:2, movewindow"
          ",longpress:3, resizewindow"
        ];
        # Binds
        bind = [
          # Basics
          "SUPER, Q, exec, uwsm app -- alacritty"
          "SUPER, C, killactive,"
          "SUPER SHIFT, Escape, exec, systemctl --user start wlogout.service"
          "SUPER, E, exec, uwsm app -- index"
          "SUPER, V, togglefloating,"
          "SUPER, R, exec, uwsm app -- rofi -show drun"
          "SUPER, L, exec, uwsm app -- hyprlock --immediate"
          "SUPER, F, fullscreen,"
          "SUPER, O, overview:toggle,"
          "SUPER, Print, exec, uwsm app -- grimblast copy area"
          ", XF86PowerOff, exec, uwsm app -- wlogout"
          # Volume and brightness controls
          ", XF86AudioMute, exec, ${volumeScript} --toggle"
          ", XF86AudioLowerVolume, exec, ${volumeScript} --dec"
          ", XF86AudioRaiseVolume, exec, ${volumeScript} --inc"
          ", XF86MonBrightnessUp, exec, ${brightnessScript} --inc"
          ", XF86MonBrightnessDown, exec, ${brightnessScript} --dec"
          # Move focus
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"
          # Switch workspace
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
          # Workspace movement
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
          # Special workspaces
          "SUPER, S, togglespecialworkspace, browser"
          "SUPER SHIFT, W, workspace, name:"
          "SUPER, P, workspace, name:dashboard"
          "SUPER SHIFT, S, movetoworkspace, special:browser"
          "SUPER SHIFT, P, movetoworkspace, name:dashboard"
          # Workspace scroll
          "SUPER, mouse_down, workspace, e+1"
          "SUPER, mouse_up, workspace, e-1"

          # Sound effects
          "SUPER, S, exec, canberra-gtk-play -i message-highlight -d \"openBrowser\""
          "SUPER SHIFT, W, exec, canberra-gtk-play -i service-login -d \"openWaydroid\""
          "SUPER, Print, exec, canberra-gtk-play -i dialog-question -d \"screenshot\""
          "SUPER, L, exec, canberra-gtk-play -i service-logout -d \"hyprlock\""
          "SUPER, V, exec, canberra-gtk-play -i outcome-success -d \"floating\""
          "SUPER, F, exec, canberra-gtk-play -i outcome-success -d \"fullscreen\""
          "SUPER, C, exec, canberra-gtk-play -i outcome-failure -d \"close\""
          "SUPER, 1, exec, canberra-gtk-play -i completion-rotation"
          "SUPER, 2, exec, canberra-gtk-play -i completion-rotation"
          "SUPER, 3, exec, canberra-gtk-play -i completion-rotation"
          "SUPER, 4, exec, canberra-gtk-play -i completion-rotation"
          "SUPER, 5, exec, canberra-gtk-play -i completion-rotation"
          "SUPER, 6, exec, canberra-gtk-play -i completion-rotation"
          "SUPER, 7, exec, canberra-gtk-play -i completion-rotation"
          "SUPER, 8, exec, canberra-gtk-play -i completion-rotation"
          "SUPER, 9, exec, canberra-gtk-play -i completion-rotation"
          "SUPER, 0, exec, canberra-gtk-play -i completion-rotation"
          "SUPER SHIFT, 1, exec, canberra-gtk-play -i completion-partial"
          "SUPER SHIFT, 2, exec, canberra-gtk-play -i completion-partial"
          "SUPER SHIFT, 3, exec, canberra-gtk-play -i completion-partial"
          "SUPER SHIFT, 4, exec, canberra-gtk-play -i completion-partial"
          "SUPER SHIFT, 5, exec, canberra-gtk-play -i completion-partial"
          "SUPER SHIFT, 6, exec, canberra-gtk-play -i completion-partial"
          "SUPER SHIFT, 7, exec, canberra-gtk-play -i completion-partial"
          "SUPER SHIFT, 8, exec, canberra-gtk-play -i completion-partial"
          "SUPER SHIFT, 9, exec, canberra-gtk-play -i completion-partial"
          "SUPER SHIFT, 0, exec, canberra-gtk-play -i completion-partial"
        ];
        # Move and resize
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

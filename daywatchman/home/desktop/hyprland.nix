{
  pkgs,
  lib,
  inputs,
  ...
}:
# Options for Hyprland and XDG
{
  imports = [ ./accessories.nix ];

  # Hyprland Window Manager
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
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      systemd.enable = true;
      xwayland.enable = true;
      plugins = [
        inputs.hyprgrass.packages.${pkgs.system}.default
        inputs.hyprfocus.packages.${pkgs.system}.hyprfocus
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
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
          "aa-notify -p -s 1 -w 60 -f /var/log/audit/audit.log"
          # Sync brightness of screens
          "brightnessctl set --device=asus_screenpad `brightnessctl get --device=intel_backlight`"
          "notify-send 'Welcome to Hyprland'"
          "canberra-gtk-play -i desktop-login -d \"welcome\""
        ];
        env = lib.mapAttrsToList (name: value: "${name},${toString value}") {
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          ELM_DISPLAY = "wl";
          SDL_VIDEODRIVER = "wayland";
        };

        # Window, workspace and layer rules
        windowrulev2 = [
          "float, class:(polkit-kde-authentication-agent-1)"
          "center, class:(polkit-kde-authentication-agent-1)"
          "stayfocused, class:(polkit-kde-authentication-agent-1)"
          "size 50% 40%, class:(polkit-kde-authentication-agent-1)"
          "float, class:(xdg-desktop-portal-gtk)"
          "workspace name: silent, class:(Waydroid)"
          "fullscreen, class:(Waydroid)"
        ];
        layerrule = [
          "noanim, swww-daemon"
          "animation slide right, notifications"
        ];
        workspace = [
          "special:browser, on-created-empty:qutebrowser"
          "name:dashboard, monitor:DP-1, persistent:true, default:true"
        ];

        # Options
        general = {
          gaps_in = 8;
          gaps_out = 16;
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
        plugin.touch_gestures = {
          sensitivity = 2.0;
          workspace_swipe_fingers = 4;
          workspace_swipe_edge = "no";
        };
        plugin.hyprfocus = {
          enabled = "yes";
          animate_floating = "yes";
          animate_workspacechange = "yes";
          focus_animation = "shrink";
          bezier = [ "realsmooth, 0.28,0.29,.69,1.08" ];
          shrink = {
            shrink_percentage = 0.99;
            in_bezier = "realsmooth";
            in_speed = 1;
            out_bezier = "realsmooth";
            out_speed = 2;
          };
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

        # Touchscreen binds
        hyprgrass-bind = [
          ",swipe:4:l, togglespecialworkspace, browser"
        ];
        hyprgrass-bindm = [
          ",longpress:2, movewindow"
          ",longpress:3, resizewindow"
        ];
        # Binds
        "$mainMod" = "SUPER";
        "$terminal" = "alacritty";
        "$fileManager" = "dolphin";
        "$menu" = "rofi -show drun";
        bind = [
          # Basics
          "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod SHIFT, Escape, exec, wlogout"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, $menu"
          "$mainMod, L, exec, hyprlock --immediate"
          "$mainMod, F, fullscreen,"
          "$mainMod, Print, exec, grimblast copy area"
          # Volume and brightness controls
          ", XF86AudioMute, exec, ${volumeScript} --toggle"
          ", XF86AudioLowerVolume, exec, ${volumeScript} --dec"
          ", XF86AudioRaiseVolume, exec, ${volumeScript} --inc"
          ", XF86MonBrightnessUp, exec, ${brightnessScript} --inc"
          ", XF86MonBrightnessDown, exec, ${brightnessScript} --dec"
          # Move focus
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          # Switch workspace
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
          # Workspace movement
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
          # Special workspaces
          "$mainMod, S, togglespecialworkspace, browser"
          "$mainMod SHIFT, W, workspace, name:"
          "$mainMod, P, workspace, name:dashboard"
          "$mainMod SHIFT, S, movetoworkspace, special:browser"
          "$mainMod SHIFT, P, movetoworkspace, name:dashboard"
          # Workspace scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          # Sound effects
          "$mainMod, S, exec, canberra-gtk-play -i message-highlight -d \"openBrowser\""
          "$mainMod SHIFT, W, exec, canberra-gtk-play -i service-login -d \"openWaydroid\""
          "$mainMod, Print, exec, canberra-gtk-play -i dialog-question -d \"screenshot\""
          "$mainMod, L, exec, canberra-gtk-play -i service-logout -d \"hyprlock\""
          "$mainMod SHIFT, Escape, exec, canberra-gtk-play -i desktop-logout -d \"wlogout\""
          "$mainMod, V, exec, canberra-gtk-play -i outcome-success -d \"floating\""
          "$mainMod, F, exec, canberra-gtk-play -i outcome-success -d \"fullscreen\""
          "$mainMod, C, exec, canberra-gtk-play -i outcome-failure -d \"close\""
          "$mainMod, 1, exec, canberra-gtk-play -i completion-rotation"
          "$mainMod, 2, exec, canberra-gtk-play -i completion-rotation"
          "$mainMod, 3, exec, canberra-gtk-play -i completion-rotation"
          "$mainMod, 4, exec, canberra-gtk-play -i completion-rotation"
          "$mainMod, 5, exec, canberra-gtk-play -i completion-rotation"
          "$mainMod, 6, exec, canberra-gtk-play -i completion-rotation"
          "$mainMod, 7, exec, canberra-gtk-play -i completion-rotation"
          "$mainMod, 8, exec, canberra-gtk-play -i completion-rotation"
          "$mainMod, 9, exec, canberra-gtk-play -i completion-rotation"
          "$mainMod, 0, exec, canberra-gtk-play -i completion-rotation"
          "$mainMod SHIFT, 1, exec, canberra-gtk-play -i completion-partial"
          "$mainMod SHIFT, 2, exec, canberra-gtk-play -i completion-partial"
          "$mainMod SHIFT, 3, exec, canberra-gtk-play -i completion-partial"
          "$mainMod SHIFT, 4, exec, canberra-gtk-play -i completion-partial"
          "$mainMod SHIFT, 5, exec, canberra-gtk-play -i completion-partial"
          "$mainMod SHIFT, 6, exec, canberra-gtk-play -i completion-partial"
          "$mainMod SHIFT, 7, exec, canberra-gtk-play -i completion-partial"
          "$mainMod SHIFT, 8, exec, canberra-gtk-play -i completion-partial"
          "$mainMod SHIFT, 9, exec, canberra-gtk-play -i completion-partial"
          "$mainMod SHIFT, 0, exec, canberra-gtk-play -i completion-partial"
        ];
        # Move and resize
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
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

  # XDG Config
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = "nvim.desktop";
        "application/pdf" = "org.kde.okular.desktop";
        "image/jpeg" = "pix.desktop";
        "image/png" = "pix.desktop";
        "inode/directory" = "org.kde.dolphin.desktop";
        "text/html" = "qutebrowser.desktop";
        "x-scheme-handler/http" = "qutebrowser.desktop";
        "x-scheme-handler/https" = "qutebrowser.desktop";
        "x-scheme-handler/about" = "qutebrowser.desktop";
        "x-scheme-handler/unknown" = "qutebrowser.desktop";
      };
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
      config = {
        common = {
          default = [ "gtk" ];
        };
        hyprland = {
          default = [
            "hyprland"
            "gtk"
          ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
          "org.freedesktop.impl.portal.Secret" = [ "pass_secret_service" ];
        };
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    # Override some desktop entries
    desktopEntries = {
      # Fix Electron IME
      "obsidian" = {
        name = "Obsidian";
        icon = "obsidian";
        comment = "Knowledge base";
        exec = "obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime";
        type = "Application";
        mimeType = [ "x-scheme-handler/obsidian" ];
        categories = [ "Office" ];
        settings = {
          Version = "1.4";
        };
      };
      "qq" = {
        name = "QQ";
        icon = "${pkgs.qq}/share/icons/hicolor/512x512/apps/qq.png";
        comment = "QQ";
        terminal = false;
        exec = "qq --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime";
        type = "Application";
        categories = [ "Network" ];
        settings = {
          StartupWMClass = "QQ";
        };
      };
    };
  };
}

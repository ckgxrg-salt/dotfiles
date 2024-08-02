{ config, pkgs, lib, inputs, ... }:
# Options for Hyprland and XDG
{
  imports = [ ./accessories.nix ];

  # Hyprland Window Manager
  wayland.windowManager.hyprland = let
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
      	            LIGHT=$(printf "%.0f\n" $(brightnessctl g))
      	            echo "$LIGHT"
                  }
                  get_icon() {
      	            current="$(get_backlight)"
      	            if [[ ("$current" -ge "0") && ("$current" -le "80") ]]; then
      		            icon="$iDIR/brightness-20.png"
      	            elif [[ ("$current" -ge "80") && ("$current" -le "160") ]]; then
      		            icon="$iDIR/brightness-40.png"
      	            elif [[ ("$current" -ge "160") && ("$current" -le "240") ]]; then
      		            icon="$iDIR/brightness-60.png"
      	            elif [[ ("$current" -ge "240") && ("$current" -le "320") ]]; then
      		            icon="$iDIR/brightness-80.png"
      	            elif [[ ("$current" -ge "320") && ("$current" -le "400") ]]; then
      		            icon="$iDIR/brightness-100.png"
      	            fi
                  }
                  notify_user() {
      	            notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Brightness : $(get_backlight)"
                  }
                  inc_backlight() {
      	            brightnessctl --device=intel_backlight set 5%+ & brightnessctl --device=card1-eDP-2-backlight set 5%+ && get_icon && notify_user
                  }
                  dec_backlight() {
      	            brightnessctl --device=intel_backlight set 5%- & brightnessctl --device=card1-eDP-2-backlight set 5%- && get_icon && notify_user
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
  in {
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
        "eDP-1, highres, 0x0, 1.25, transform, 2"
        "eDP-2, highres, 0x1440, 1.25"
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
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
        "playerctld"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "waybar"
        "ags -t \"bar0\""
        "fcitx5"
        "udiskie &"
        "nm-applet"
        "nwg-drawer -r -fm dolphin -term alacritty -wm hyprland -pbexit wlogout"
        "aa-notify -p -s 1 -w 60 -f /var/log/audit/audit.log"
        # Sync brightness of screens
        "brightnessctl set --device=card1-eDP-2-backlight `brightnessctl get --device=intel_backlight`"
        "notify-send 'Welcome to Hyprland'"
      ];
      env = lib.mapAttrsToList (name: value: "${name},${toString value}") {
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        ELM_DISPLAY = "wl";
        SDL_VIDEODRIVER = "wayland";
        QT_QPA_PLATFORMTHEME = "qt6ct";
      };

      # Window, workspace and layer rules
      windowrulev2 = [
        "float, class:(org.kde.polkit-kde-authentication-agent-1)"
        "center, class:(org.kde.polkit-kde-authentication-agent-1)"
        "float, class:(xdg-desktop-portal-gtk)"
        "float, class:(QQ)"
        "center, class:(QQ)"
        "workspace name: , class:(Waydroid)"
        "fullscreen, class:(Waydroid)"
      ];
      layerrule =
        [ "noanim, swww-daemon" "animation slide right, notifications" ];
      workspace = [
        "name: , monitor:eDP-1, default:true, persistent:true"
        "name: , monitor:eDP-2, default:true, persistent:true"
        "special:browser, on-created-empty:qutebrowser"
      ];

      # Options
      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 2;
        "col.active_border" = "rgba(bf4bf8aa) rgba(56f1ffaa) 45deg";
        "col.inactive_border" = "rgba(44306133)";
        layout = "dwindle";
        allow_tearing = false;
        resize_on_border = true;
      };
      dwindle = {
        smart_split = true;
        smart_resizing = true;
        no_gaps_when_only = 2;
      };
      plugin.touch_gestures = {
        sensitivity = 1.0;
        workspace_swipe_edge = "d";
        workspace_swipe_fingers = 3;
        long_press_delay = 400;
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
        workspace_swipe_cancel_ratio = 0.15;
      };
      misc = {
        force_default_wallpaper = -1;
      };
      xwayland = { force_zero_scaling = true; };

      # Somehow "fancy" effects
      decoration = {
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
        active_opacity = 0.95;
        inactive_opacity = 0.85;
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

      # Touchscreen binds
      hyprgrass-bind = [
        ",edge:r:l, togglespecialworkspace, browser"
        ",edge:d:u, exec, pkill -RTMIN wvkbd-desktop"
        ",edge:u:d, togglespecialworkspace, controlcentre"
        ",edge:u:d, exec, ags -t \"bar0\""
        ",edge:u:d, exec, pkill -RTMIN wvkbd-desktop"
      ];
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "dolphin";
      "$menu" = "nwg-drawer";
      bind = [
        # Basics
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod SHIFT, Escape, exec, wlogout"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod SHIFT, A, togglespecialworkspace, controlcentre"
        "$mainMod SHIFT, A, exec, pkill -RTMIN wvkvd-desktop"
        "$mainMod SHIFT, A, exec, ags -t \"bar0\""
        "$mainMod, P, swapactiveworkspaces, eDP-1 eDP-2"
        "$mainMod, R, exec, $menu"
        "$mainMod, L, exec, hyprlock --immediate"
        "$mainMod, F, fullscreen,"
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
        "$mainMod CONTROL, 1, workspace, name: "
        "$mainMod CONTROL, 2, workspace, name: "
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
        "$mainMod SHIFT CONTROL, 1, movetoworkspace, name: "
        "$mainMod SHIFT CONTROL, 2, movetoworkspace, name: "
        # Special workspaces
        "$mainMod, S, togglespecialworkspace, browser"
        "$mainMod SHIFT, W, workspace, name: "
        "$mainMod SHIFT, S, movetoworkspace, special:browser"
        # Workspace scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];
      # Move and resize
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
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
        "image" = "pix.desktop";
        "inode/directory" = "org.kde.dolphin.desktop";
      };
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      config = {
        common = { default = [ "gtk" ]; };
        hyprland = {
          default = [ "hyprland" "gtk" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    # Override some desktop entries
    desktopEntries = {
      "io.github.msojocs.bilibili" = {
        name = "Bilibili";
        genericName = "Video Centre";
        icon = "io.github.msojocs.bilibili";
        exec = "bilibili --ozone-platform-hint=auto";
        terminal = false;
        categories = [ "Network" "AudioVideo" ];
      };
      "org.qutebrowser.qutebrowser" = {
        name = "Qutebrowser";
        genericName = "Web Browser";
        icon = "browser";
        exec = "qutebrowser";
        terminal = false;
        categories = [ "Network" "WebBrowser" ];
      };
    };
  };
}

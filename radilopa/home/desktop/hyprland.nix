{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
# Options for Hyprland and XDG
{
  imports = [ ./accessories.nix ];

  # Hyprland Window Manager
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enable = true;
    xwayland.enable = true;
    settings = {
      # Hardware
      monitor = [
        ",highres, auto, 1.25"
        "Unknown-1, disable"
      ];
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
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1"
        "playerctld"
        "swww-daemon"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "waybar"
        "fcitx5"
        "udiskie &"
        "notify-send 'Welcome to Hyprland'"
      ];
      env = lib.mapAttrsToList (name: value: "${name},${toString value}") {
        LIBVA_DRIVER_NAME = "nvidia";
        XDG_SESSION_TYPE = "wayland";
        GBM_BACKEND = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        NVD_BACKEND = "direct";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
      };

      # Window and workspace rules
      windowrulev2 = [
        "float,class:(org.kde.polkit-kde-authentication-agent-1)"
        "float,class:(bilibili),initialTitle:(undefined)"
        "float, class:(xdg-desktop-portal-gtk)"
        "float, class:(QQ)"
        "center, class:(QQ)"
      ];
      workspace = [ "special:browser, on-created-empty:qutebrowser" ];

      # Some options
      general = {
        gaps_in = 2;
        gaps_out = 2;
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
      };
      gestures = {
        workspace_swipe = false;
      };
      misc = {
        force_default_wallpaper = -1;
      };
      xwayland = {
        force_zero_scaling = true;
      };

      # Fancy effects
      decoration = {
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
        drop_shadow = false;
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
      "$mainMod" = "SUPER";
      "$terminal" = "alacritty";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show drun";
      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod SHIFT CONTROL, Escape, exit,"
        "$mainMod SHIFT, Escape, exec, wlogout"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, R, exec, $menu"
        "$mainMod, J, togglesplit,"
        "$mainMod, L, exec, hyprlock --immediate"
        "$mainMod, F, fullscreen,"
        # Volume and brightness controls
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        # Switch workspaces with mainMod + [0-9]
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
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
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
        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, browser"
        "$mainMod SHIFT, S, movetoworkspace, special:browser"
        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];
      # Move/resize windows with mainMod + LMB/RMB and dragging
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
        "text/plain" = "codium.desktop";
        "application/pdf" = "org.kde.okular.desktop";
      };
    };
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
      config = {
        common = {
          default = [ "gtk" ];
        };
        hyprland = {
          default = [ "hyprland" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
          "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
        };
      };
    };
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    desktopEntries = {
      "io.github.msojocs.bilibili" = {
        name = "Bilibili";
        genericName = "Video Centre";
        icon = "io.github.msojocs.bilibili";
        exec = "bilibili --ozone-platform-hint=auto";
        terminal = false;
        categories = [
          "Network"
          "AudioVideo"
        ];
      };
      "nvitop" = {
        name = "Nvitop";
        genericName = "Nvidia GPU Monitor";
        icon = "Alacritty";
        exec = "nvitop";
        terminal = true;
      };
    };
  };
}

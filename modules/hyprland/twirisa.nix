{ config, pkgs, lib, inputs, ... }:
{
    imports = [
        ./accessories.nix
    ];

    # Hyprland Window Manager
    wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        systemd.enable = true;
        xwayland.enable = true;
        plugins = [
            #inputs.hyprland-plugins.packages.${pkgs.system}.hyprtrails
            #inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
        ];
        settings = {
            monitor=",highres,auto,1";
            plugin = {
                hyprtrails = {
                    color = "rgba(ffaa00ff)";
                };
                hyprexpo = {
                    columns = 3;
                    gap_size = 5;
                    bg_col = "rgb(111111)";
                    workspace_method = "center current";
                    enable_gesture = true;
                    gesture_distance = 300;
                    gesture_positive = true;
                };
            };
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
            windowrulev2 = [
                "float,class:(org.kde.polkit-kde-authentication-agent-1)"
                "float,class:(bilibili)"
                "float,class:(QQ)"
            ];
            "$terminal" = "alacritty";
            "$fileManager" = "thunar";
            "$menu" = "rofi -show drun";
            env = lib.mapAttrsToList (name: value: "${name},${toString value}"){
                ELECTRON_OZONE_PLATFORM_HINT = "auto";
            };
            input = {
                kb_layout = "us";
                follow_mouse = 1;
                touchpad = {
                    natural_scroll = true;
                };
                sensitivity = 0;
            };
            general = {
                gaps_in = 5;
                gaps_out = 20;
                border_size = 2;
                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";
                layout = "dwindle";
                allow_tearing = false;
            };
            decoration = {
                rounding = 10;
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
            dwindle = {
                pseudotile = true;
                preserve_split = true;
            };
            master = {
                new_is_master = true;
            };
            gestures = {
                workspace_swipe = false;
            };
            misc = {
                force_default_wallpaper = -1;
            };
            "$mainMod" = "SUPER";
            bind = [
                "$mainMod, Q, exec, $terminal"
                "$mainMod, C, killactive,"
                "$mainMod SHIFT CONTROL, Escape, exit,"
                "$mainMod SHIFT, Escape, exec, wlogout"
                "$mainMod, E, exec, $fileManager"
                "$mainMod, V, togglefloating,"
                "$mainMod, R, exec, $menu"
                "$mainMod, P, pseudo,"
                "$mainMod, J, togglesplit,"
                "$mainMod, L, exec, hyprlock"
                "$mainMod, F, fullscreen,"
                #"$mainMod, O, hyprexpo:expo, toggle"
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
                "$mainMod, S, togglespecialworkspace, magic"
                "$mainMod SHIFT, S, movetoworkspace, special:magic"
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
                xdg-desktop-portal-kde
                xdg-desktop-portal-gtk
            ];
            config = {
                common = {
                    default = [ "gtk" ];
                };
                hyprland = {
                    default = [
                        "hyprland"
                        "gtk"
                    ];
                    "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
                    #"org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
                };
            };
        };
        userDirs = {
            enable = true;
            createDirectories = true;
        };
        desktopEntries = {
            bilibili = {
                name = "Bilibili";
                genericName = "Video Centre";
                exec = "bilibili --ozone-platform-hint=auto";
                terminal = false;
                categories = [ "Network" "AudioVideo" ];
            };
        };
    };
}

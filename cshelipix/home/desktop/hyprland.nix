{ config, pkgs, lib, inputs, ... }:
# Options for Hyprland and XDG
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
            inputs.hyprgrass.packages.${pkgs.system}.default
        ];
        settings = {
            # Hardware
            monitor= [
                "eDP-1, highres, 0x0, 1.25, transform, 2"
                "eDP-2, highres, 0x1800, 1.25"
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
                "swww-daemon"
                "wl-paste --type text --watch cliphist store"
                "wl-paste --type image --watch cliphist store"
                "waybar"
                "fcitx5"
                "udiskie &"
                "nwg-drawer -r -fm dolphin -term alacritty -wm hyprland -pbexit wlogout"
                "notify-send 'Welcome to Hyprland'"
            ];
            env = lib.mapAttrsToList (name: value: "${name},${toString value}"){
                ELECTRON_OZONE_PLATFORM_HINT = "auto";
                ELM_DISPLAY = "wl";
                SDL_VIDEODRIVER = "wayland";
            };

            # Window, workspace and layer rules
            windowrulev2 = [
                "float, class:(org.kde.polkit-kde-authentication-agent-1)"
                "center, class:(org.kde.polkit-kde-authentication-agent-1)"
                "float, class:(bilibili)"
                "float, class:(QQ)"
                "center, class:(QQ)"
                "size 1280 900, class:(QQ)"
                "workspace special:waydroid, class:(Waydroid)"
            ];
            layerrule = [
                "noanim, swww-daemon"
                "animation slide right, notifications"
            ];
            workspace = [
                "name:Panel, monitor:eDP-2, default:true, persistent:true"
                "special:browser, on-created-empty:firefox"
            ];
            
            # Options
            general = {
                gaps_in = 0;
                gaps_out = 0;
                border_size = 0;
                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";
                layout = "dwindle";
                allow_tearing = false;
                resize_on_border = true;
            };
            dwindle = {
                smart_split = true;
            };
            plugin.touch_gestures = {
                sensitivity = 1.0;
                workspace_swipe_fingers = 3;
                workspace_swipe_edge = "d";
                long_press_delay = 400;
            };
            gestures = {
                workspace_swipe = true;
                workspace_swipe_touch = true;
                workspace_swipe_cancel_ratio = 0.15;
            };
            misc = {
                force_default_wallpaper = -1;
            };
            xwayland = {
                force_zero_scaling = true;
            };

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
                inactive_opacity = 0.75;
                dim_inactive = true;
            };
            animations = {
                enabled = true;
                bezier = [
                    "easeInOutBack, 0.68, -0.55, 0.265, 1.55"
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
                    "workspaces, 1, 4, easeInOutBack, slidefadevert"
                    "specialWorkspace, 1, 4, easeInOutBack, slide"
                ];
            };
            
            # Touchscreen binds
            hyprgrass-bind = [
                ",edge:r:l, togglespecialworkspace, browser"
            ];
            "$mainMod" = "SUPER";
            "$terminal" = "alacritty";
            "$fileManager" = "dolphin";
            "$menu" = "nwg-drawer";
            bind = [
                # Basics
                "$mainMod, Q, exec, $terminal"
                "$mainMod, C, killactive,"
                "$mainMod SHIFT CONTROL, Escape, exit,"
                "$mainMod SHIFT, Escape, exec, wlogout"
                "$mainMod, E, exec, $fileManager"
                "$mainMod, V, togglefloating,"
                "$mainMod, R, exec, $menu"
                "$mainMod, L, exec, hyprlock --immediate"
                "$mainMod, F, fullscreen,"
                # Volume and brightness controls
                ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
                ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05-"
                ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05+"
                ", XF86MonBrightnessDown, exec, brightnessctl --device=intel_backlight set 5%- & brightnessctl --device=card1-eDP-2-backlight set 5%-"
                ", XF86MonBrightnessUp, exec, brightnessctl --device=intel_backlight set 5%+ & brightnessctl --device=card1-eDP-2-backlight set 5%+"
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
                "$mainMod, P, workspace, name:Panel"
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
                "$mainMod SHIFT, P, movetoworkspace, name:Panel"
                # Special workspaces
                "$mainMod, S, togglespecialworkspace, browser"
                "$mainMod SHIFT, W, togglespecialworkspace, waydroid"
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
            };
        };
        portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-kde
                xdg-desktop-portal-wlr
            ];
            config = {
                common = {
                    default = [ "wlr" ];
                };
                hyprland = {
                    default = [
                        "hyprland"
                        "gtk"
                    ];
                    "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
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
        };
    };
}

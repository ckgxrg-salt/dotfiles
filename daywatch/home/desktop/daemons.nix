{ pkgs, ... }:
# Daemons for the desktop environment
{
  systemd.user.services = {
    # A Solution to your Wayland Wallpaper Woes
    "swww-daemon" = {
      Unit = {
        Description = "A Solution to your Wayland Wallpaper Woes";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # Cliphist the clipboard manager
    "cliphist" = {
      Unit = {
        Description = "Clipboard History Manager";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "wl-paste --type text --watch cliphist store";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
    "cliphist-images" = {
      Unit = {
        Description = "Clipboard History Manager";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "wl-paste --type image --watch cliphist store";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # Mako the lightweight notification daemon
    "mako" = {
      Unit = {
        Description = "Lightweight Wayland notification daemon";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${pkgs.mako}/bin/mako";
        ExecReload = "${pkgs.mako}/bin/makoctl reload";
        Slice = "background-graphical.slice";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # A daemon that controls music players
    "playerctld" = {
      Unit = {
        Description = "Music Player Control";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.playerctl}/bin/playerctld";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # The sidebar
    "waybar" = {
      Unit = {
        Description = "A Lightweight Wayland Sidebar";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
        Slice = "app-graphical.slice";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # NetworkManager Applet
    "nm-applet" = {
      Unit = {
        Description = "NetworkManager Applet";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
        Restart = "on-failure";
        Slice = "app-graphical.slice";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # Udiskie Automount
    "udiskie" = {
      Unit = {
        Description = "Udiskie Auto Mount Manager";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.udiskie}/bin/udiskie --event-hook \"canberra-gtk-play -i device-added\"";
        Restart = "on-failure";
        Slice = "app-graphical.slice";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # Polkit Authentication Agent
    "polkit-hyprland-agent" = {
      Unit = {
        Description = "Polkit Hyprland Authentication Agent";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
        Slice = "app-graphical.slice";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}

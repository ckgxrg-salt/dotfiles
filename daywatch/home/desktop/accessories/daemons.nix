{ pkgs, ... }:
# Run the extra programs as daemons
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
        ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
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
    "polkit-gnome-agent" = {
      Unit = {
        Description = "GNOME's Polkit Authentication Agent";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        Slice = "app-graphical.slice";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
    # Battery indicator
    "cbatticon" = {
      Unit = {
        Description = "Battery Indicator";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.cbatticon}/bin/cbatticon -u 60 -i symbolic -l 15 -r 5 -o \"notify-send -i battery 'Low Battery' '15% Battery Remaining'\" -c \"notify-send -i battery 'Low Battery' 'Only 5% Battery Remaining'\"";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}

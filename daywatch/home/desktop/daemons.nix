{
  pkgs,
  ...
}:
# Daemons for the desktop environment
{
  systemd.user.services = {
    # a Solution to your Wayland Wallpaper Woes
    "swww-daemon" = {
      Unit = {
        Description = "A Solution to your Wayland Wallpaper Woes";
        Requires = [ "hyprland-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
    # Mako the lightweight notification daemon
    "mako" = {
      Unit = {
        Description = "Lightweight Wayland notification daemon";
        Requires = [ "hyprland-session.target" ];
      };
      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${pkgs.mako}/bin/mako";
        ExecReload = "${pkgs.mako}/bin/makoctl reload";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
    # A daemon that controls music players
    "playerctld" = {
      Unit = {
        Description = "Music Player Control";
        Requires = [ "hyprland-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.playerctl}/bin/playerctld";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
    # The sidebar
    "waybar" = {
      Unit = {
        Description = "A Lightweight Wayland Sidebar";
        Requires = [ "hyprland-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.waybar}/bin/waybar";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
    # NetworkManager Applet
    "nm-applet" = {
      Unit = {
        Description = "NetworkManager Applet";
        Requires = [ "hyprland-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
    # Udiskie Automount
    "udiskie" = {
      Unit = {
        Description = "Udiskie Auto Mount Manager";
        Requires = [ "hyprland-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.udiskie}/bin/udiskie --event-hook \"canberra-gtk-play -i device-added\"";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
    # Polkit Authentication Agent
    "polkit-hyprland-agent" = {
      Unit = {
        Description = "Polkit Hyprland Authentication Agent";
        Requires = [ "hyprland-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
  };
}

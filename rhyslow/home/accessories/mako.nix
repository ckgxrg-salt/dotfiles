{ config, pkgs, ... }:
{
  # Mako the Notification Daemon
  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      border-radius = 15;
      icon-path = "${config.home.profileDirectory}/share/icons/${config.theme.icon.name}";
      max-icon-size = 64;
      icons = true;
      height = 150;
      width = 450;
      max-visible = 3;
    };
  };

  # Run as daemon
  systemd.user.services."mako" = {
    Unit = {
      Description = "Lightweight Wayland notification daemon";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "dbus";
      BusName = "org.freedesktop.Notifications";
      ExecStart = "${pkgs.mako}/bin/mako";
      ExecReload = "${pkgs.mako}/bin/makoctl reload";
      Restart = "on-failure";
      Slice = "background-graphical.slice";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}

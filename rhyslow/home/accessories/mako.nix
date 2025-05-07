{ config, pkgs, ... }:
{
  # Mako the Notification Daemon
  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      borderRadius = 15;
      defaultTimeout = 15000;
      iconPath = "${config.home.profileDirectory}/share/icons/${config.theme.icon.name}";
      maxIconSize = 64;
      icons = true;
      height = 150;
      width = 450;
      maxVisible = 3;
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

{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.daemons.mako;
in
{
  options.daemons.mako = mkEnableOption "Enable mako notification daemon";

  config = mkIf cfg {
    services.mako = {
      enable = true;
      settings = {
        output = "DP-1";
        anchor = "bottom-right";
        border-radius = 0;
        background-color = "#8fbcbb66";
        border-color = "#4c566a66";
        height = 150;
        width = 450;
        icons = true;
        max-icon-size = 64;
        max-visible = 3;
        #icon-path = "${config.home.profileDirectory}/share/icons/${config.theme.icon.name}";
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
  };
}

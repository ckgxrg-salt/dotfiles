{
  config,
  lib,
  pkgs,
  ...
}:
# WayVNC service and session
with lib;
let
  cfg = config.services.wayvnc;
in
{
  options.services.wayvnc = {
    enable = mkEnableOption "Enable WayVNC, VNC server for Wayland.";
    package = mkOption {
      type = types.package;
      description = "The WayVNC package to use.";
      default = pkgs.wayvnc;
    };
    openFirewall = mkEnableOption "Opens firewall port.";
    port = mkOption {
      type = types.str;
      description = "The port VNC server listens on.";
      default = "5900";
    };
    address = mkOption {
      type = types.str;
      description = "The address VNC server listens on.";
      default = "127.0.0.1";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];

    systemd.user.services."wayvnc" = {
      description = "WayVNC Server";
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "exec";
        Restart = "always";
        ExecStart = "${cfg.package}/bin/wayvnc ${cfg.address} ${cfg.port}";
        Slice = "background-graphical.slice";
      };
    };
  };
}

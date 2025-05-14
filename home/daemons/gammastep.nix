{ config, lib, ... }:
with lib;
let
  cfg = config.daemons.gammastep;
in
{
  options.daemons.gammastep = mkEnableOption "Enable Gammastep colour temperature adjuster";

  config = mkIf cfg {
    services.gammastep = {
      enable = true;
      tray = false;

      # Current position
      longitude = 117.1;
      latitude = 36.7;
      provider = "manual";

      temperature = {
        day = 6500;
        night = 5500;
      };

      settings = {
        general = {
          fade = 1;
          adjustment-method = "wayland";
        };
      };
    };
    # ...and because of UWSM we again need to overwrite the systemd service
    systemd.user.services."gammastep" = {
      Unit = {
        PartOf = lib.mkForce [ ];
        After = lib.mkForce [ "graphical-session.target" ];
      };
      Service = {
        Slice = lib.mkForce "background-graphical.slice";
      };
    };
  };
}

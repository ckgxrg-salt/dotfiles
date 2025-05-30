{
  config,
  osConfig,
  lib,
  ckgs,
  ...
}:
with lib;
let
  cfg = config.daemons.astal;
in
{
  options.daemons.astal = {
    enable = mkEnableOption "Enable Astal desktop widgets";
    autoreload = mkEnableOption "Reload Astal everyday";
  };

  config =
    let
      variant =
        if osConfig.networking.hostName == "Daywatch" then
          ckgs.astal.daywatch
        else if osConfig.networking.hostName == "Vistath" then
          ckgs.astal.vistath
        else
          abort "No astal implementation for this device";
      packages =
        if osConfig.networking.hostName == "Daywatch" then
          [
            ckgs.astal.daywatch.main
            ckgs.astal.daywatch.logout
          ]
        else if osConfig.networking.hostName == "Vistath" then
          [
            ckgs.astal.vistath.main
            ckgs.astal.vistath.logout
          ]
        else
          abort "No astal implementation for this device";
    in
    mkIf cfg.enable {
      home.packages = packages;

      systemd.user = {
        services = {
          "astal" = {
            Unit = {
              Description = "Astal Desktop Widgets";
              PartOf = [ "graphical-session.target" ];
            };
            Service = {
              Type = "exec";
              ExecStart = "${variant.main}/bin/astal";
              Restart = "on-failure";
            };
            Install = {
              WantedBy = [ "graphical-session.target" ];
            };
          };
          "astal-reload" = mkIf cfg.autoreload {
            Unit = {
              Description = "Reload Astal everyday";
              Requisite = [ "astal.service" ];
              After = [ "astal.service" ];
            };
            Service = {
              Type = "oneshot";
              ExecStart = "${variant.main}/bin/astal reload";
              Restart = "on-failure";
              RestartSec = "10s";
            };
          };
        };
        timers."astal-reload" = mkIf cfg.autoreload {
          Unit = {
            Description = "Reload Astal everyday";
            Requisite = [ "astal.service" ];
          };
          Timer = {
            OnCalendar = "daily";
            Persistent = true;
          };
          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
}

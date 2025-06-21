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
      package =
        if osConfig.networking.hostName == "Asedia" then
          ckgs.astal.asedia
        else
          abort "No astal implementation for this device";
    in
    mkIf cfg.enable {
      home.packages = [ package ];

      systemd.user = {
        services = {
          "astal" = {
            Unit = {
              Description = "Astal Desktop Shell";
              PartOf = [ "graphical-session.target" ];
            };
            Service = {
              Type = "exec";
              ExecStart = "${package}/bin/astal-shell";
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
              ExecStart = "${package}/bin/astal-shell reload";
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

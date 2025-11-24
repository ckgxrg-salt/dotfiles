{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.vdirsyncer;
in
{
  options.program.vdirsyncer = {
    enable = mkEnableOption "Enable default vdirsyncer settings";
    autoUpdate = mkEnableOption "Periodically run vdirsyncer";
  };

  config = mkIf cfg.enable {
    programs.vdirsyncer = {
      enable = true;
      statusPath = "${config.xdg.configHome}/vdirsyncer/status";
    };

    systemd.user = mkIf cfg.autoUpdate {
      services."vdirsyncer" = {
        Unit = {
          Description = "Calendar & contacts sync";
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${pkgs.vdirsyncer}/bin/vdirsyncer sync --force-delete";
          Restart = "no";
        };
      };
      timers."vdirsyncer" = {
        Unit = {
          Description = "Periodically run vdirsyncer";
        };
        Timer = {
          OnBootSec = "5m";
          OnUnitActiveSec = "15m";
        };
        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}

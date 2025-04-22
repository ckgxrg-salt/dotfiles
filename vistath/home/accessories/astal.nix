{ vistath-astal, ... }:
# Astal desktop widgets
{
  home.packages = [
    vistath-astal.packages.x86_64-linux.default
    vistath-astal.packages.x86_64-linux.logout
  ];

  systemd.user = {
    services = {
      # Astal desktop shell
      "astal" = {
        Unit = {
          Description = "Astal Desktop Widgets";
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "exec";
          ExecStart = "${vistath-astal.packages.x86_64-linux.default}/bin/vistath-astal";
          Restart = "on-failure";
          Slice = "background-graphical.slice";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
      "astal-reload" = {
        Unit = {
          Description = "Reload Astal everyday";
          Requires = [ "graphical-session.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${vistath-astal.packages.x86_64-linux.default}/bin/vistath-astal reload";
          Restart = "on-failure";
          RestartSec = "10s";
        };
      };
    };
    timers."astal-reload" = {
      Unit = {
        Description = "Reload Astal everyday";
        Requires = [ "graphical-session.target" ];
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
}

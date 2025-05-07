{
  config,
  lib,
  pkgs,
  ...
}:
# Hyprland's idle daemon
{
  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        {
          timeout = 360;
          on-timeout = "hyprlock";
          on-resume = ''notify-send "Resumed from Idle"'';
        }
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  # A small fix when using uwsm as the session manager
  systemd.user.services."hypridle" = lib.mkForce {
    Unit = {
      Description = "Hyprland's Idle Daemon";
      After = "graphical-session.target";
      X-Restart-Triggers = [ "${config.xdg.configFile."hypr/hypridle.conf".source}" ];
    };
    Service = {
      Type = "exec";
      ExecStart = lib.getExe pkgs.hypridle;
      Restart = "on-failure";
      Slice = "background-graphical.slice";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}

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
      lock_cmd = "pidof hyprlock || hyprlock --immediate";
      unlock_cmd = "pkill -USR1 hyprlock";
      before_sleep_cmd = "hyprctl dispatch dpms off";
      after_sleep_cmd = "hyprctl dispatch dpms on";
      listener = [
        {
          timeout = 180;
          on-timeout = "pidof hyprlock || hyprlock";
          on-resume = ''notify-send "Kids, I'm back"'';
        }
        {
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "systemctl suspend-then-hibernate";
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

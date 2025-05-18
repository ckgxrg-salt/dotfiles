{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.daemons.hypridle;
in
{
  options.daemons.hypridle = mkEnableOption "Enable hypridle idle daemon";

  config = mkIf cfg {
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
  };
}

{ ... }:
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
}

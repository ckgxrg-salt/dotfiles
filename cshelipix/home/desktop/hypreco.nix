{ config, lib, ... }:
# Options for some hypr* programs
{
  # Hyprlock the screen-locker
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = false;
        grace = 60;
      };
      background = [{
        color = "rgba(59, 66, 82, 0.6)";
        blur_passes = 3;
        blur_size = 7;
        noise = 0.0117;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      }];
      label = [{
        monitor = "eDP-1";
        text = "Out for Lunch";
        text_align = "center";
        position = "0, 80";
        halign = "center";
        valign = "center";
        font_size = 48;
        font_family = "Maple Mono";
        color = "rgba(216, 222, 233)";
      }];
      input-field = [{
        monitor = "eDP-1";
        size = "300, 75";
        position = "0, -120";
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        capslock_color = "rgb(128, 25, 38)";
        outline_thickness = 5;
        fade_on_empty = false;
        placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
        shadow_passes = 2;
      }];
    };
  };

  # Hypridle the idle daemon
  services.hypridle = {
    enable = true;
    settings = {
      listener = [
        {
          timeout = 180;
          on-timeout = "hyprlock";
          on-resume = "notify-send \"Resumed from Idle\"";
        }
        {
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";  
        }
      ];
    };
  };
}
{ config, lib, ... }:
with lib;
let
  cfg = config.daemons.hyprlock;
in
{
  options.daemons.hyprlock = {
    enable = mkEnableOption "Enable hyprlock screen locker";
  };

  config = mkIf cfg.enable {
    stylix.targets.hyprlock = {
      enable = true;
      useWallpaper = false;
    };

    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          hide_cursor = false;
          grace = 60;
        };
        background = {
          blur_passes = 3;
          blur_size = 7;
          noise = 1.17e-2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };
        label = {
          monitor = "eDP-1";
          text = "Out for Lunch";
          text_align = "center";
          position = "0, 80";
          halign = "center";
          valign = "center";
          font_size = 48;
        };
        input-field = {
          monitor = "eDP-1";
          size = "300, 75";
          position = "0, -120";
          outline_thickness = 5;
          fade_on_empty = false;
          placeholder_text = ''<span foreground="##cad3f5">Who asked you...</span>'';
          fail_text = "sus";
          shadow_passes = 2;
        };
      };
    };
  };
}

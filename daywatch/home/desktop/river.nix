{ ... }:
# A dynamic tiling Wayland compositor
{
  wayland.windowManager.river = {
    enable = true;
    # In favour of UWSM
    systemd.enable = false;
    xwayland.enable = true;
    settings = {
      declare-mode = [
        "normal"
        "screenlock"
      ];
      map = {
        normal = {
          # Basics
          "Super Q" = "spawn 'uwsm app -- alacritty'";
          "Super C" = "close";
          "Super+Shift Escape" = "spawn 'systemctl --user start wlogout'";
          "Super R" = "spawn 'uwsm app -- rofi -show drun'";
          "Super F" = "toggle-fullscreen";
          "Super V" = "toggle-floating";
          "Super Print" = "spawn 'uwsm app -- grimblast copy area'";

          # Move focus
          "Super left" = "focus-view left";
          "Super right" = "focus-view right";
          "Super up" = "focus-view up";
          "Super down" = "focus-view down";
        };
      };
    };
  };
}

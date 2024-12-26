{ pkgs, ... }:
# A dynamic tiling Wayland compositor
{
  wayland.windowManager.river = {
    enable = true;
    package = null;
    # In favour of UWSM
    systemd.enable = false;
    xwayland.enable = true;
    settings = {
      default-layout = "rivertile";
      focus-follows-cursor = "normal";
      declare-mode = [
        "normal"
        "screenlock"
      ];
      map = {
        normal = {
          # Basics
          "Super Q" = "spawn 'uwsm app -- alacritty'";
          "Super C" = "close";
          "None XF86PowerOff" = "spawn 'uwsm app -- wlogout'";
          "Super R" = "spawn 'uwsm app -- rofi -show drun'";
          "Super F" = "toggle-fullscreen";
          "Super V" = "toggle-float";
          "Super Print" = "spawn 'uwsm app -- grimblast copy area'";
          "Super L" = "spawn 'uwsm app -- hyprlock --immediate'";

          # Move focus
          "Super left" = "focus-view left";
          "Super right" = "focus-view right";
          "Super up" = "focus-view up";
          "Super down" = "focus-view down";

          # Snap
          "Super+Shift J" = "snap down";
          "Super+Shift K" = "snap up";
          "Super+Shift L" = "snap right";
          "Super+Shift H" = "snap left";
        };
      };
      # Mouse buttons
      map-pointer = {
        normal = {
          "Super BTN_LEFT" = "move-view";
          "Super BTN_RIGHT" = "resize-view";
        };
      };
    };
    extraConfig = ''
      rivertile -view-padding 6 -outer-padding 10 -main-location right
      ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP NIXOS_OZONE_WL XCURSOR_THEME XCURSOR_SIZE
    '';
  };
}

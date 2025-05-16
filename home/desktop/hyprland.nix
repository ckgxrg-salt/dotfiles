{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.desktop.hyprland;
in
{
  options.desktop.hyprland = mkEnableOption "Enable default Hyprland settings";

  config = mkIf cfg {
    stylix.targets.hyprland.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      xwayland.enable = true;
      settings = {
        # Hardware
        input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = true;
            tap-to-click = true;
            tap-and-drag = true;
            disable_while_typing = false;
          };
          sensitivity = 0;
        };
        binds = {
          scroll_event_delay = 20;
        }; # Options

        general = {
          resize_on_border = true;
          snap = {
            enabled = true;
          };
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          new_window_takes_over_fullscreen = 2;
          disable_hyprland_qtutils_check = true;
          enable_anr_dialog = false;
        };

        # Move, resize and scroller mode
        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];
      };
    };
  };
}

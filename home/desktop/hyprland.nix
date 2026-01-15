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
  options.desktop.hyprland = {
    enable = mkEnableOption "Enable default Hyprland settings";
  };

  config = mkIf cfg.enable {
    stylix.targets.hyprland.enable = true;

    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = true;
        enableXdgAutostart = true;
        variables = [ "--all" ];
      };
      xwayland.enable = true;
      settings = {
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
        };

        general = {
          resize_on_border = true;
          snap = {
            enabled = true;
          };
        };
        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          enable_anr_dialog = false;
        };
        ecosystem = {
          no_update_news = true;
          no_donation_nag = true;
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

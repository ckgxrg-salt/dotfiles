{ config, ... }:
{
  # Dependent on mode of Cshelipix, use different targets to change the configuration.
  systemd.user.targets = {
    # Ordinary Laptop mode
    "laptop" = {
      Unit = {
        Description = "Laptop Layout";
        Requires = [ "hyprland-session.target" ];
        Conflicts = [ "tablet.target" "tent.target" ];
      };
      # This is the default mode when entering Hyprland session.
      Install = {
        WantedBy = [ "hyprland-session.target" ];
      };
    };
    # Only main screen active, touchscreen oriented mode
    "tablet" = {
      Unit = {
        Description = "Tablet Layout";
        Requires = [ "hyprland-session.target" ];
        Conflicts = [ "laptop.target" "tent.target" ];
      };
    };
    # Another layout, similar to tablet
    "tent" = {
      Unit = {
        Description = "Tent Layout";
        Requires = [ "hyprland-session.target" ];
        Conflicts = [ "laptop.target tablet.target" ];
      };
    };
  };

  # When switching to a certain mode, do some initialisation work
  systemd.user.services = {
    "laptop-init" = {
      Unit = {
        Description = "Initialise Desktop Layout";
        After = [ "laptop.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "bash -c \"hyprctl dispatch dpms on\"";
      };
      Install = {
        WantedBy = [ "laptop.target"];
      };
    };
    "tablet-init" = {
      Unit = {
        Description = "Initialise Tablet Layout";
        After = [ "tablet.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = [
          "bash -c \"hyprctl dispatch dpms on eDP-1\""
          "bash -c \"hyprctl dispatch dpms off eDP-2\""
        ];
      };
      Install = {
        WantedBy = [ "tablet.target" ];
      };
    };
    "tent-init" = {
      Unit = {
        Description = "Initialise Tent Layout";
        After = [ "tent.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = [
          "bash -c \"hyprctl dispatch dpms on eDP-2\""
          "bash -c \"hyprctl dispatch dpms off eDP-1\""
        ];
      };
      Install = {
        WantedBy = [ "tent.target" ];
      };
    };
  };
}
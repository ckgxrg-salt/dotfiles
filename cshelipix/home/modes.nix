{ pkgs, ... }: {
  # Dependent on mode of Cshelipix, use different targets to change the configuration.
  systemd.user.targets = {
    # Ordinary Laptop mode
    "laptop" = {
      Unit = {
        Description = "Laptop Layout";
        Requires = [ "hyprland-session.target" ];
        Conflicts = [ "tablet.target" "tent.target" "book.target" ];
      };
      # This is the default mode when entering Hyprland session.
      Install = { WantedBy = [ "hyprland-session.target" ]; };
    };
    # Only main screen active, touchscreen oriented mode
    "tablet" = {
      Unit = {
        Description = "Tablet Layout";
        Requires = [ "hyprland-session.target" ];
        Conflicts = [ "laptop.target" "tent.target" "book.target" ];
      };
    };
    # Another layout, similar to tablet
    "tent" = {
      Unit = {
        Description = "Tent Layout";
        Requires = [ "hyprland-session.target" ];
        Conflicts = [ "laptop.target tablet.target" "book.target" ];
      };
    };
    # Layout which screens are rotated
    "book" = {
      Unit = {
        Description = "Book Layout";
        Requires = [ "hyprland-session.target" ];
        Conflicts = [ "laptop.target" "tablet.target" "tent.target" ];
        OnSuccess = [ "book-finalise.service" ];
      };
    };
  };

  # When switching to a certain mode, do some initialisation work
  systemd.user.services = {
    # Activate both screens and restore touchscreen
    "laptop-init" = let
      script = pkgs.writeShellScript "laptop-init-script" ''
        hyprctl --batch "keyword input:touchdevice:output \"\"; \
                        keyword monitor eDP-1,highres,0x0,1.25,transform,2; \
                        keyword monitor eDP-2,highres,0x1440,1.25; \
                        dispatch dpms on"
      '';
    in {
      Unit = {
        Description = "Initialise Desktop Layout";
        After = [ "laptop.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${script}";
      };
      Install = { WantedBy = [ "laptop.target" ]; };
    };
    # Deactivate bottom screen and rebind touchscreen
    "tablet-init" = let
      script = pkgs.writeShellScript "tablet-init-script" ''
        hyprctl --batch "keyword input:touchdevice:output eDP-1; \
                        keyword monitor eDP-1,highres,0x0,1.5,transform,2; \
                        dispatch focusmonitor eDP-1; \
                        dispatch dpms on eDP-1; \
                        dispatch dpms off eDP-2"
      '';
    in {
      Unit = {
        Description = "Initialise Tablet Layout";
        After = [ "tablet.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${script}";
      };
      Install = { WantedBy = [ "tablet.target" ]; };
    };
    # Deactivate top screen and rebind touchscreen
    "tent-init" = let
      script = pkgs.writeShellScript "tent-init-script" ''
        hyprctl --batch "keyword input:touchdevice:output eDP-2; \
                        keyword monitor eDP-2,highres,0x1440,1.25; \
                        dispatch focusmonitor eDP-2; \
                        dispatch dpms off eDP-1; \
                        dispatch dpms on eDP-2"
      '';
    in {
      Unit = {
        Description = "Initialise Tent Layout";
        After = [ "tent.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${script}";
      };
      Install = { WantedBy = [ "tent.target" ]; };
    };
    # Rotate screens, touchscreens and tablets
    "book-init" = let
      script = pkgs.writeShellScript "book-init-script" ''
        hyprctl --batch "keyword monitor eDP-1,highres,0x0,1.25,transform,3; \
                        keyword monitor eDP-2,highres,-1440x0,1.25,transform,1; \
                        keyword input:tablet:transform 1; \
                        keyword input:touchdevice:transform 1; \
                        dispatch dpms on"
      '';
    in {
      Unit = {
        Description = "Initialise Book Layout";
        After = [ "book.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${script}";
      };
      Install = { WantedBy = [ "book.target" ]; };
    };
    # Restore screens, touchscreens and tablets
    "book-finalise" = let
      script = pkgs.writeShellScript "book-exit-script" ''
        hyprctl --batch "keyword input:tablet:transform 0; \
                        keyword input:touchdevice:transform 0"
      '';
    in {
      Unit = {
        Description = "Finalises Book Layout";
        Conflicts = [ "book.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${script}";
      };
    };

    # Load WVKBD according to modes
    "wvkbd-desktop" = {
      Unit = {
        Description = "WVKBD Virtual Keyboard";
        Conflicts = [ "laptop.target" "tent.target" ];
      };
      Service = {
        ExecStart = "${
            pkgs.callPackage ../../packages/wvkbd-desktop.nix { }
          }/bin/wvkbd-desktop --hidden -L 512 --fn 'Maple Mono 16' --press '81a1c1' --alpha 230";
        Restart = "always";
      };
      Install = { WantedBy = [ "tablet.target" "book.target" ]; };
    };
  };
}

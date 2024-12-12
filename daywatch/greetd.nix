{
  pkgs,
  ckgs,
  config,
  lib,
  ...
}:
{
  # greetd Session Manager
  services.greetd =
    let
      # Cage cannot handle multi-screen circumstance...
      hyprConfig = pkgs.writeText "regreet-hyprland" ''
        monitor=eDP-1,preferred,auto,1
        monitor=DP-1,disabled
        device {
          name = elan9008:00-04f3:2d55
          output = eDP-1
        }
        device {
          name = elan9009:00-04f3:2c1b
          enabled = false
        }
        device {
          name = elan9008:00-04f3:2d55-stylus
          output = eDP-1
        }
        device {
          name = elan9009:00-04f3:2c1b-stylus
          enabled = false
        }
        misc {
          disable_hyprland_logo = true
        }
        animations {
          enabled = false
        }
        exec-once = ${lib.getExe pkgs.greetd.regreet}; hyprctl dispatch exit
      '';
    in
    {
      enable = true;
      vt = 7;
      settings = {
        # Skip login for the initial boot
        initial_session = {
          command = "uwsm start -S Hyprland";
          user = "ckgxrg";
        };
        # Ask ReGreet for login process
        default_session = {
          command = "${pkgs.dbus}/bin/dbus-run-session ${lib.getExe pkgs.hyprland} -c ${hyprConfig}";
          user = "greeter";
        };
      };
    };

  # Background image
  environment.etc."regreet/background-img.png" = {
    source = "${config.users.users.ckgxrg.home}/Pictures/Wallpapers/desert-sunset.png";
    user = "greeter";
    mode = "660";
  };

  # ReGreet greeter
  programs.regreet = {
    enable = true;

    # Themes
    theme = {
      name = "Everforest-Dark-BL";
      package = pkgs.everforest-gtk-theme;
    };
    cursorTheme = {
      name = "GoogleDot-Black";
      package = ckgs.googledot-cursor;
    };
    font = {
      name = "Maple UI";
      size = 16;
      package = ckgs.maple-ui;
    };
    iconTheme = {
      name = "Qogir-dark";
      package = pkgs.qogir-icon-theme;
    };

    # Config
    settings = {
      background = {
        path = "/etc/regreet/background-img.png";
        fit = "Fill";
      };
      appearance = {
        greeting_msg = "<-- The Daywatch Site -->";
      };
      commands = {
        reboot = [
          "systemctl"
          "reboot"
        ];
        poweroff = [
          "systemctl"
          "poweroff"
        ];
      };
    };
  };

  # Universal Wayland Session Manager
  programs.uwsm = {
    enable = true;
    waylandCompositors = lib.mkForce {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland Session";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
    };
  };
}

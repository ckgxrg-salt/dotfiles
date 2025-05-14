{
  config,
  pkgs,
  ckgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.login.greetd;
in
{
  options.login.greetd = {
    enable = mkEnableOption "Enable greetd login manager";
    greetMessage = mkOption {
      type = types.str;
      description = "Greet message displayed by the greeter";
    };
  };
  # greetd Session Manager
  services.greetd =
    let
      hyprConfig = pkgs.writeText "regreet-hyprland" ''
        monitor=,preferred,auto,1
        misc {
          disable_hyprland_logo = true
          disable_hyprland_qtutils_check = true
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
        # Manually copy the image to this path
        path = "/etc/regreet/background-img";
        fit = "Fill";
      };
      appearance = {
        greeting_msg = cfg.greetMessage;
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

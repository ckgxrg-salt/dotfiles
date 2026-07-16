{
  config,
  pkgs,
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
    autoLogin = mkEnableOption "Automatically log in for the first time";
    greetMessage = mkOption {
      type = types.str;
      description = "Greet message displayed by the greeter";
      default = "===== ${config.device.hostname} =====";
    };
  };

  config = mkIf cfg.enable {
    # greetd Session Manager
    services.greetd =
      let
        hyprConfig = pkgs.writeText "regreet-hyprland" ''
          monitor=,preferred,auto,1
          misc {
            disable_hyprland_logo = true
            disable_splash_rendering = true
            enable_anr_dialog = false
          }
          ecosystem {
            no_update_news = true
            no_donation_nag = true
          }
          animations {
            enabled = false
          }
          exec-once = ${lib.getExe pkgs.regreet}; hyprctl dispatch exit
        '';
      in
      {
        enable = true;
        settings = {
          # Skip login for the initial boot
          initial_session = mkIf cfg.autoLogin {
            command = "${pkgs.hyprland}/bin/start-hyprland";
            user = "ckgxrg";
          };
          # Ask ReGreet for login process
          default_session = {
            command = "${pkgs.hyprland}/bin/start-hyprland -- -c ${hyprConfig}";
            user = "greeter";
          };
        };
      };

    # ReGreet greeter
    # Manually do stylix things to silence the warning
    programs.regreet = {
      enable = true;
      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3";
      };
      settings = {
        GTK = {
          application_prefer_dark_theme = true;
          cursor_theme_name = mkForce config.theme.cursor.name;
          font_name = mkForce "${config.stylix.fonts.sansSerif.name} ${toString config.stylix.fonts.sizes.applications}";
          icon_theme_name = mkForce config.stylix.icons.dark;
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
  };
}

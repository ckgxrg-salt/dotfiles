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
          initial_session = mkIf cfg.autoLogin {
            command = "${lib.getExe pkgs.hyprland}";
            user = "ckgxrg";
          };
          # Ask ReGreet for login process
          default_session = {
            command = "${lib.getExe pkgs.hyprland} -c ${hyprConfig}";
            user = "greeter";
          };
        };
      };

    # ReGreet greeter
    # Manually do stylix things to silence the warning
    programs.regreet = {
      enable = true;
      settings = {
        GTK.application_prefer_dark_theme = config.stylix.polarity == "dark";
        font = {
          inherit (config.stylix.fonts.sansSerif) name package;
        };
        cursorTheme = lib.mkIf (config.stylix.cursor != null) {
          inherit (config.stylix.cursor) name package;
        };
        theme = {
          package = pkgs.adw-gtk3;
          name = "adw-gtk3";
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

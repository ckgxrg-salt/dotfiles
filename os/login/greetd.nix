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
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        # Skip login for the initial boot
        initial_session = mkIf cfg.autoLogin {
          command = "${pkgs.hyprland}/bin/start-hyprland";
          user = "ckgxrg";
        };
        # Ask ReGreet for login process
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet";
          user = "greeter";
        };
      };
    };

    environment = {
      systemPackages = with pkgs; [ tuigreet ];
      etc."tuigreet/config.toml".text = ''
        [display]
        show_time = true
        issue = true

        [remember]
        username = true
        session = false
        user_session = true

        [session]
        sessions_dirs = ["${pkgs.hyprland}/share/wayland-sessions"]

        [secret]
        mode = "characters"
        characters = "*"

        [keybindings]
        command = 2
        sessions = 3
        background = 4
        power = 12

        [background]
        kind = "none"
      '';
    };
  };
}

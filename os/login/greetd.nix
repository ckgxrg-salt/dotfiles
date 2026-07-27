{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.login.greetd;
in
{
  options.login.greetd = {
    enable = lib.mkEnableOption "Enable greetd login manager";
    autoLogin = lib.mkEnableOption "Automatically log in for the first time";
    greetMessage = lib.mkOption {
      type = lib.types.str;
      description = "Greet message displayed by the greeter";
      default = "===== ${config.device.hostname} =====";
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sessionPackages = [ pkgs.niri ];

    # greetd Session Manager
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        # Skip login for the initial boot
        initial_session = lib.mkIf cfg.autoLogin {
          command = "${pkgs.niri}/bin/niri-session";
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
      systemPackages = with pkgs; [
        tuigreet
        niri
      ];
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

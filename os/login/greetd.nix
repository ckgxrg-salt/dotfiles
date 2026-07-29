{ pkgs, ... }:
{
  config = {
    services.displayManager.sessionPackages = [ pkgs.niri ];

    # greetd Session Manager
    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
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
        sessions_dirs = ["${pkgs.niri}/share/wayland-sessions"]

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

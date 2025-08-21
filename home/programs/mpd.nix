{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
let
  cfg = config.program.mpd;
in
{
  options.program.mpd = mkEnableOption "Enable the Music Player Daemon";

  config = mkIf cfg {
    # MPD
    services.mpd = {
      enable = true;
      musicDirectory = config.xdg.userDirs.music;
      network = {
        listenAddress = "127.0.0.1";
        port = 6600;
        startWhenNeeded = false;
      };
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "Pipewire"
        }
      '';
    };
    # Start MPD on-demand
    systemd.user.services."mpd".Install = lib.mkForce { };
    systemd.user.services."mpd-mpris".Install = lib.mkForce { };

    # MPRIS implementation for MPD
    services.mpd-mpris = {
      enable = true;
      mpd.useLocal = true;
    };

    # Accessories
    home.packages = with pkgs; [
      mpc
      mpd-notification
      ymuse
    ];

    # Notification Service
    systemd.user.services."mpd-notification" = {
      Unit = {
        Description = "Notifications for MPD";
        Requires = [ "mpd.service" ];
      };
      Service = {
        ExecStart = "${pkgs.mpd-notification}/bin/mpd-notification";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "mpd.service" ];
      };
    };

    # Config Notifications
    xdg.configFile."mpd-notification.conf".text = ''
      host = localhost
      port = 6600
      music-dir = ${config.xdg.userDirs.music}
      scale = 200
      text-topic = MPD
      text-play = Playing <b>%t</b>\nby <i>%a</i>\nfrom <i>%A</i>
      text-pause = Paused <b>%t</b>\nby <i>%a</i>\nfrom <i>%A</i>
      text-stop = Stopped playback
      timeout = 5
    '';
  };
}

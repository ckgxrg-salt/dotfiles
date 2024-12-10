{ pkgs, config, ... }:
# The Music Player Daemon
{
  # MPD
  services.mpd = {
    enable = true;
    musicDirectory = config.xdg.userDirs.music;
    network = {
      listenAddress = "127.0.0.1";
      port = 6600;
      startWhenNeeded = true;
    };
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "Pipewire"
      }
    '';
  };

  # MPRIS implementation for MPD
  services.mpdris2 = {
    enable = true;
    multimediaKeys = true;
    notifications = true;
  };

  # MPD Client
  home.packages = with pkgs; [ rofi-mpd ];
}

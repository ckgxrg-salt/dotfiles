{ pkgs, config, ... }:
# Another Music Player Daemon
{
  # Mopidy
  services.mopidy = {
    enable = true;
    extensionPackages = with pkgs; [
      mopidy-mpd
      mopidy-mpris
      mopidy-local
      mopidy-notify
    ];
    settings = {
      local = {
        media_dir = config.xdg.userDirs.music;
        scan_follow_symlinks = true;
      };
      mpd = {
        hostname = "127.0.0.1";
        port = 6600;
      };
      notify = {
        enabled = true;
        fallback_icon = "notification-audio-play";
        track_summary = "\${track}";
        track_message = "\${artists} - \${album}";
      };
    };
  };

  # Accessories
  home.packages = with pkgs; [
    mpc
    ymuse
  ];
}

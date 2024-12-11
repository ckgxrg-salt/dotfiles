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
    };
  };

  # Accessories
  home.packages = with pkgs; [
    mpc
    ymuse
  ];
}

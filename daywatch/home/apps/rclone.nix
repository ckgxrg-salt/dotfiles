{ config, pkgs, ... }:
# Syncs files from Nextcloud
{
  programs.rclone = {
    enable = true;
    remotes = {
      paralace = {
        config = {
          type = "webdav";
          url = "https://paralace.ckgxrg.io/remote.php/dav/files/ckgxrg";
          vendor = "nextcloud";
          user = "ckgxrg";
        };
        secrets = {
          pass = "/run/system-keys/paralace-passwd";
        };
      };
    };
  };

  # Auto-sync some directories
  systemd.user = let
  base = {
    Unit.Requires = [ "network-online.target" ];
    Service.Type = "oneshot";
    Install.WantedBy = [ "multi-user.target" ];
  };
  base-timer = {
    Unit.Requires = [ "network-online.target" ];
    Install.WantedBy = [ "timers.target" ];
  };
  in {
    services = {
      "rclone-Music" = base // {
        Unit.Description = "Sync Music with rclone";
        Service.ExecStart = "${pkgs.rclone}/bin/rclone bisync ${config.xdg.userDirs.music} paralace:Music";
      };
    };
    timers = {
      "rclone-Music" = base-timer // {
        Unit.Description = "Sync Music with rclone";
        Timer = {
          OnBootSec = "1h";
          OnUnitActiveSec = "1h";
        };
      };
    };
  };
}

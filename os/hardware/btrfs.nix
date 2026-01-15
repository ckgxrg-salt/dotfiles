{ config, lib, ... }:
with lib;
let
  cfg = config.hardware.btrfs;
in
{
  options.hardware.btrfs = mkEnableOption "Enable default Btrfs configurations";

  config = mkIf cfg {
    services.btrfs = {
      autoScrub.enable = true;
    };

    services.snapper =
      let
        enable = {
          TIMELINE_CREATE = true;
          TIMELINE_CLEANUP = true;
        };
      in
      {
        snapshotInterval = "hourly";
        cleanupInterval = "daily";
        configs = {
          "rootfs" = enable // {
            SUBVOLUME = "/";
            TIMELINE_LIMIT_YEARLY = 0;
            TIMELINE_LIMIT_HOURLY = 0;
            TIMELINE_LIMIT_DAILY = 0;
            TIMELINE_LIMIT_WEEKLY = 2;
            TIMELINE_LIMIT_MONTHLY = 1;
          };
          "home" = enable // {
            SUBVOLUME = "/home";
            TIMELINE_LIMIT_YEARLY = 0;
            TIMELINE_LIMIT_HOURLY = 5;
            TIMELINE_LIMIT_DAILY = 5;
            TIMELINE_LIMIT_WEEKLY = 2;
            TIMELINE_LIMIT_MONTHLY = 2;
          };
          "var" = enable // {
            SUBVOLUME = "/var";
            TIMELINE_LIMIT_YEARLY = 0;
            TIMELINE_LIMIT_HOURLY = 0;
            TIMELINE_LIMIT_DAILY = 5;
            TIMELINE_LIMIT_WEEKLY = 2;
            TIMELINE_LIMIT_MONTHLY = 1;
          };

          "games" = enable // {
            SUBVOLUME = "/home/ckgxrg/Games";
            TIMELINE_LIMIT_YEARLY = 0;
            TIMELINE_LIMIT_HOURLY = 2;
            TIMELINE_LIMIT_DAILY = 2;
            TIMELINE_LIMIT_WEEKLY = 0;
            TIMELINE_LIMIT_MONTHLY = 0;
          };
        };
      };
  };
}

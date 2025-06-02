{ config, lib, ... }:
with lib;
let
  cfg = config.hardware.zfs;
in
{
  options.hardware.zfs = mkEnableOption "Enable default ZFS configurations";

  config = mkIf cfg {
    services.zfs = {
      trim.enable = true;
      autoScrub.enable = true;
    };

    services.sanoid = {
      enable = true;
      templates."default" = {
        autosnap = true;
        autoprune = true;
        hourly = 2;
        daily = 5;
        weekly = 2;
        monthly = 1;
      };
    };
  };
}

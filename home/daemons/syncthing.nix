{ config, lib, ... }:
let
  cfg = config.daemons.syncthing;
in
{
  options.daemons.syncthing = {
    enable = lib.mkEnableOption "Enable Syncthing file syncer";
  };

  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      overrideDevices = false;
      overrideFolders = false;
      settings = {
        options = {
          urAccepted = -1;
          crashReportingEnabled = false;
        };
      };
    };
  };
}

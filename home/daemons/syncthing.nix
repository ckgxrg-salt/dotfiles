{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.daemons.syncthing;
in
{
  options.daemons.syncthing = mkEnableOption "Enable Syncthing file syncer";

  config = mkIf cfg {
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

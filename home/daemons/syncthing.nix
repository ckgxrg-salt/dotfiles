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
      settings = {
        options = {
          urAccepted = -1;
          crashReportingEnabled = false;
        };
        devices = {
          everpivot = {
            id = "FWSB7NV-QGTUB5L-XB7OINQ-G3QNMCL-IFXFKDS-XSDUVRU-QP35RJN-6SRQGQO";
            name = "Everlight Pivot";
          };
        };
      };
    };
  };
}

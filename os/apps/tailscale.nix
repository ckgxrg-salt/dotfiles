{ config, lib, ... }:
with lib;
let
  cfg = config.apps.tailscale;
in
{
  options.apps.tailscale = mkEnableOption "Enable Tailscale service";

  config = mkIf cfg {
    services.tailscale = {
      enable = true;
      extraDaemonFlags = [
        "-no-logs-no-support"
      ];
    };
  };
}

{ config, lib, ... }:
with lib;
let
  cfg = config.program.tailscale;
in
{
  options.program.tailscale = mkEnableOption "Enable Tailscale service";

  config = mkIf cfg {
    services.tailscale = {
      enable = true;
      extraDaemonFlags = [
        "-no-logs-no-support"
      ];
    };
  };
}

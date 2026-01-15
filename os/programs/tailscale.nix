{ config, lib, ... }:
with lib;
let
  cfg = config.program.tailscale;
in
{
  options.program.tailscale = {
    enable = mkEnableOption "Enable Tailscale service";
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      extraDaemonFlags = [
        "-no-logs-no-support"
      ];
    };
  };
}

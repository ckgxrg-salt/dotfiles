{ config, lib, ... }:
with lib;
let
  cfg = config.program.netbird;
in
{
  options.program.netbird = {
    enable = mkEnableOption "Enable Netbird service";
  };

  config = mkIf cfg.enable {
    services.netbird = {
      enable = true;
    };
  };
}

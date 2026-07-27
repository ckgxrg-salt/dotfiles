{ config, lib, ... }:
let
  cfg = config.program.netbird;
in
{
  options.program.netbird = {
    enable = lib.mkEnableOption "Enable Netbird service";
  };

  config = lib.mkIf cfg.enable {
    services.netbird = {
      enable = true;
    };
  };
}

{ config, lib, ... }:
let
  cfg = config.program.sunshine;
in
{
  options.program.sunshine = {
    enable = lib.mkEnableOption "Enable default Sunshine settings";
  };

  config = lib.mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
    };
  };
}

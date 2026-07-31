{ config, lib, ... }:
let
  cfg = config.daemons.hypridle;
in
{
  options.daemons.hypridle = {
    enable = lib.mkEnableOption "Enable hypridle idle daemon";
  };

  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true;
      settings = {
        listener = [
          {
            timeout = 180;
            on-timeout = "pidof hyprlock || hyprlock --grace 600";
          }
          {
            timeout = 600;
            on-timeout = "niri msg action power-off-monitors";
          }
        ];
      };
    };
  };
}

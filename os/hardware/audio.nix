{ config, lib, ... }:
let
  cfg = config.hardware;
in
{
  config = lib.mkIf cfg.default {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}

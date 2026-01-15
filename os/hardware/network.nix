{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.hardware;
in
{
  options.hardware = {
    wifi = mkEnableOption "Support Wi-Fi";
    bt = mkEnableOption "Support Bluetooth";
  };

  config = mkIf cfg.default {
    networking = {
      networkmanager = mkIf cfg.wifi {
        enable = true;
        wifi = {
          backend = "iwd";
          powersave = true;
        };
        plugins = lib.mkForce [ ];
      };

      firewall = {
        # Localsend
        allowedTCPPorts = [
          53317
        ];
      };
    };

    services.avahi = {
      enable = true;
      openFirewall = true;
      nssmdns4 = true;
      nssmdns6 = true;
    };

    hardware.bluetooth = mkIf cfg.bt {
      enable = true;
      powerOnBoot = true;
    };
  };
}

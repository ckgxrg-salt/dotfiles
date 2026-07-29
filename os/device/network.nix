{ config, lib, ... }:
let
  cfg = config.device;
in
{
  options.device = {
    wifi = lib.mkEnableOption "Support Wi-Fi";
    bt = lib.mkEnableOption "Support Bluetooth";
  };

  config = {
    networking = {
      wireless.iwd = lib.mkIf cfg.wifi {
        enable = true;
        settings = {
          General = {
            EnableNetworkConfiguration = true;
            AddressRandomization = "network";
          };
          Network = {
            NameResolvingService = "resolvconf";
          };
        };
      };
      dhcpcd = lib.mkIf cfg.wifi {
        enable = false;
      };

      firewall = {
        # Localsend
        allowedTCPPorts = [
          53317
        ];
      };

      nameservers = [
        "1.1.1.1"
      ];
    };

    services.avahi = {
      enable = true;
      openFirewall = true;
      nssmdns4 = true;
      nssmdns6 = true;
    };

    hardware.bluetooth = lib.mkIf cfg.bt {
      enable = true;
      powerOnBoot = true;
    };
  };
}

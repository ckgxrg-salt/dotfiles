{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.boot;
in
{
  options.boot = {
    default = mkEnableOption "Apply default boot configurations";
    bbr = mkEnableOption "Apply bbr congestion control algorithm";
    laptop = mkEnableOption "Apply laptop optimisations";
    noCoredump = mkEnableOption "Disable core dump files";
  };

  config = mkIf cfg.default {
    stylix.targets.console.enable = true;

    boot = {
      # Config systemd-boot
      loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
        timeout = 0;
        systemd-boot.enable = false;
      };

      initrd = {
        systemd.enable = true;
        verbose = false;
      };
      # Silent boot
      consoleLogLevel = 0;

      # Boot splash
      plymouth.enable = true;

      # Kernel params
      kernelParams =
        [
          "quiet"
          "plymouth.nolog"
          "udev.log_level=3"
        ]
        ++ optionals cfg.laptop [
          "pcie_aspm.policy=powersupersave"
        ];

      # Kernel extra config
      kernelModules = mkIf cfg.bbr [ "tcp_bbr" ];
      kernel.sysctl =
        optionalAttrs cfg.bbr {
          "net.ipv4.tcp_congestion_control" = "bbr";
          "net.ipv4.default_qdisc" = "cake";
        }
        // optionalAttrs cfg.laptop {
          "vm.laptop_mode" = 5;
          "kernel.nmi_watchdog" = 0;
        }
        // optionalAttrs cfg.noCoredump {
          "kernel.core_pattern" = "|${pkgs.coreutils}/bin/false";
        };
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.boot;
in
{
  options.boot = {
    default = lib.mkEnableOption "Apply default boot configurations";
    bbr = lib.mkEnableOption "Apply bbr congestion control algorithm";
    noCoredump = lib.mkEnableOption "Disable core dump files";
  };

  config = lib.mkIf cfg.default {
    boot = {
      loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
        timeout = 0;
      };

      tmp.cleanOnBoot = true;

      initrd = {
        verbose = false;
      };
      # Silent boot
      consoleLogLevel = 0;

      # Kernel params
      kernelParams = [
        "quiet"
        "plymouth.nolog"
        "udev.log_level=3"
      ]
      ++ lib.optionals config.device.laptop [
        "pcie_aspm.policy=powersupersave"
      ];

      # Kernel extra config
      kernelModules = lib.mkIf cfg.bbr [ "tcp_bbr" ];
      kernel.sysctl =
        lib.optionalAttrs cfg.bbr {
          "net.ipv4.tcp_congestion_control" = "bbr";
          "net.ipv4.default_qdisc" = "cake";
        }
        // lib.optionalAttrs config.device.laptop {
          "vm.laptop_mode" = 5;
          "kernel.nmi_watchdog" = 0;
        }
        // lib.optionalAttrs cfg.noCoredump {
          "kernel.core_pattern" = "|${pkgs.coreutils}/bin/false";
        };
    };
  };
}

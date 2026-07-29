{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = {
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
      kernelModules = [ "tcp_bbr" ];
      kernel.sysctl = {
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.ipv4.default_qdisc" = "cake";
        "kernel.core_pattern" = "|${pkgs.coreutils}/bin/false";
      }
      // lib.optionalAttrs config.device.laptop {
        "vm.laptop_mode" = 5;
        "kernel.nmi_watchdog" = 0;
      };
    };
  };
}

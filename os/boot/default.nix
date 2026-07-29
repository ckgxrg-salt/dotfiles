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

      # Memory optimisation
      zswap = {
        enable = true;
        compressor = "zstd";
      };

      tmp.cleanOnBoot = true;

      # Silent boot
      initrd = {
        verbose = false;
      };
      consoleLogLevel = 0;

      kernelParams = [
        "quiet"
        "plymouth.nolog"
        "udev.log_level=3"
      ]
      ++ lib.optionals config.device.laptop [
        "pcie_aspm.policy=powersupersave"
      ];

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

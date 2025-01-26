{ pkgs, lib, ... }:
# Bootstrap process
{
  imports = [ ./fstab.nix ];
  boot = {
    #========== Boot ==========#
    # Config systemd-boot
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 0;
      systemd-boot.enable = lib.mkForce false;
    };

    #========== Initrd ==========#
    initrd = {
      systemd.enable = true;
      verbose = false;
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "rtsx_usb_sdmmc"
      ];
      kernelModules = [
        "kvm-intel"
        "i915"
      ];
    };
    # Silent boot
    consoleLogLevel = 0;

    # Boot splash
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "hexa_retro";
    };

    #========== Kernel ==========#
    # Use linux-zen kernel
    kernelPackages = pkgs.linuxPackages_zen;

    # Kernel params
    kernelParams = [
      "quiet"
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
      "plymouth.nolog"
      "plymouth.use-simpledrm"
      "udev.log_level=3"
      "pcie_aspm.policy=powersupersave"
    ];

    # Kernel extra config
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
      "vm.laptop_mode" = 5;
      "kernel.nmi_watchdog" = 0;
      "kernel.core_pattern" = "|${pkgs.coreutils}/bin/false";
    };
  };
}

{
  pkgs,
  ...
}:
# Bootstrap process
{
  boot = {
    #========== Boot ==========#
    # Config systemd-boot
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot.enable = true;
    };

    #========== Initrd ==========#
    initrd = {
      systemd.enable = true;
      verbose = false;
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [
        "kvm-intel"
      ];
    };

    # Boot splash
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "connect";
    };

    #========== Kernel ==========#
    # Use Xanmod kernel with Nvidia modules
    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    # Kernel params
    kernelParams = [
      "quiet"
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
      "plymouth.nolog"
    ];

    # Kernel extra config
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
      "kernel.core_pattern" = "|${pkgs.coreutils}/bin/false";
    };
  };
}

{
  pkgs,
  config,
  lib,
  ...
}:
{
  # Boot up process
  imports = [ ./fstab.nix ];
  boot = {
    #========== Bootloader ==========#
    # Config systemd-boot
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot.enable = lib.mkForce false;
    };

    # Setup Secure Boot
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    bootspec.enable = true;

    #========== Initrd ==========#
    initrd = {
      # Use systemd instead of busybox
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
      kernelModules = [ "kvm-amd" ];
    };

    # Boot splash
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "spin";
    };

    #========== Kernel ==========#
    # Use Xanmod kernel with Nvidia modules
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    extraModulePackages = with config.boot.kernelPackages; [ lenovo-legion-module ];
    supportedFilesystems = [
      "ntfs"
    ];

    # Kernel params
    kernelParams = [
      "noefi"
      "quiet"
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
      "plymouth.nolog"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];

    # Kernel extra config
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
    };
  };
}

{
  pkgs,
  config,
  lib,
  ...
}:
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
      systemd-boot.enable = lib.mkForce false;
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
        "kvm-amd"
        "amdgpu"
      ];
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
      "kernel.core_pattern" = "|${pkgs.coreutils}/bin/false";
    };
  };
}

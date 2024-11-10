{
  pkgs,
  config,
  lib,
  ...
}:
{
  # Bootloader
  boot = {
    bootspec.enable = true;
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
    # Setup boot splash
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "spin";
    };
    # Use Xanmod kernel with Nvidia modules
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    extraModulePackages = with config.boot.kernelPackages; [ lenovo-legion-module ];
    supportedFilesystems = [
      "ntfs"
    ];
    kernelParams = [
      "noefi"
      "quiet"
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
      "plymouth.nolog"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
    # BBR Congestion Algorithm
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
    };
  };
}

{ pkgs, config, lib, ... }:
{
  # Bootloader
  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      systemd-boot.enable = lib.mkForce false;
    };
    # Setup secureboot
    lanzaboote = {
      enable = true;
      pkiBundle = "/home/ckgxrg/Keyring/SB-Bundle";
    };
    # Setup boot splash
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "liquid";
    };
    # Nvidia driver
    extraModprobeConfig = ''
      install i915 /usr/bin/false
      install intel_agp /usr/bin/false
      install viafb /usr/bin/false
      install radeon /usr/bin/false
      install amdgpu /usr/bin/false
    '';
    # Use linux-zen kernel with Nvidia modules
    kernelPackages = pkgs.linuxPackages_zen;
    extraModulePackages = with config.boot.kernelPackages; [ lenovo-legion-module nvidia_x11 ];
    initrd.kernelModules = [ "nvidia" ];
    supportedFilesystems = [ "btrfs" "ntfs" ];
    kernelParams = [
      "quiet"
      "plymouth.nolog"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
    # BBR Congestion Algorithm
    kernelModules = [
      "tcp_bbr"
    ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
    };
  };
}

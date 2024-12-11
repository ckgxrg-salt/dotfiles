{ pkgs, lib, ... }:
{

  imports = [ ./fstab.nix ];

  # Bootloader
  boot = {
    bootspec.enable = true;
    # Use systemd instead of busybox
    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    consoleLogLevel = 0;
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 0;
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
      theme = "hexa_retro";
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "noefi"
      "quiet"
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
      "plymouth.nolog"
      "udev.log_level=3"
      # Cutting-edge xe drivers, but somehow broken
      #"i915.force_probe=!9a49"
      #"xe.force_probe=9a49"
    ];
    # BBR Congestion Algorithm
    kernelModules = [ "tcp_bbr" ];
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
    };
  };
}

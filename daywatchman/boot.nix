{ pkgs, lib, ... }:
{

  imports = [ ./fstab.nix ];

  # Bootloader
  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
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
      theme = "hexagon_dots";
    };
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "noefi"
      "quiet"
      "lsm=landlock,lockdown,yama,integrity,apparmor,bpf"
      "plymouth.nolog"
      # Cutting-edge xe drivers, but somehow broken
      #"i915.force_probe=!9a49"
      #"xe.force_probe=9a49"
    ];
    kernelModules = [
      "tcp_bbr"
    ];
    # BBR Congestion Algorithm
    kernel.sysctl = {
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.default_qdisc" = "cake";
      "vm.laptop_mode" = 5;
    };
  };
}

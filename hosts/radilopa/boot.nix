{ pkgs, config, ... }:
{
  # Bootloader
  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      systemd-boot.enable = true;
    };
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "liquid";
    };
    kernelPackages = pkgs.linuxPackages_lqx;
    extraModulePackages = with config.boot.kernelPackages [ lenovo-legion-module ];
    kernelParams = [
      "quiet"
      "plymouth.nolog"
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

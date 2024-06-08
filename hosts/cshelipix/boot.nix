{ pkgs, config, ... }:
{
  # Bootloader
  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      systemd-boot.enable = true;
      #grub = {
      #  forceInstall = true;
      #  enable = true;
      #  efiSupport = true;
      #  device = "/dev/disk/by-id/nvme-SAMSUNG_MZALQ512HALU-000L2_S4UKNE0MA39584";
      #  theme = "${pkgs.sleek-grub-theme.override {
      #    withStyle = "dark";
      #    withBanner = "Twirisa";
      #  }}";
      #};
      
    };
    plymouth = {
      enable = true;
      themePackages = [ pkgs.adi1090x-plymouth-themes ];
      theme = "liquid";
    };
    kernelPackages = pkgs.linuxPackages_zen;
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
      "vm.laptop_mode" = 5;
    };
  };
}

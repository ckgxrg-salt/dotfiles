{ pkgs, config, lib, ... }: {
  # Bootloader
  boot = {
    bootspec.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
      systemd-boot.enable = lib.mkForce false;
    };
    # Setup Secure Boot
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
    # Use Xanmod kernel with Nvidia modules
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    extraModulePackages = with config.boot.kernelPackages;
      [ lenovo-legion-module ];
    supportedFilesystems = [ "btrfs" "ntfs" ];
    kernelParams = [
      "quiet"
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

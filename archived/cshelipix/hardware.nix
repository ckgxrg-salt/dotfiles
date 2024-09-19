# Hardware Configuration
{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # fstab
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/ECD0-BD1D";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
      "nodev"
      "nosuid"
      "noexec"
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ede5b4b4-7d74-46c5-8a01-5468cecbc573";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/ede5b4b4-7d74-46c5-8a01-5468cecbc573";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/ede5b4b4-7d74-46c5-8a01-5468cecbc573";
    fsType = "btrfs";
    options = [ "subvol=@nix" ];
  };

  fileSystems."/var/cache" = {
    device = "/dev/disk/by-uuid/ede5b4b4-7d74-46c5-8a01-5468cecbc573";
    fsType = "btrfs";
    options = [
      "subvol=@cache"
      "nodev"
      "nosuid"
      "noexec"
    ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/ede5b4b4-7d74-46c5-8a01-5468cecbc573";
    fsType = "btrfs";
    options = [
      "subvol=@log"
      "nodev"
      "nosuid"
      "noexec"
    ];
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/cd5f8c1e-26ac-4efe-8c3a-fb9ba3de887c"; } ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableAllFirmware = true;
}

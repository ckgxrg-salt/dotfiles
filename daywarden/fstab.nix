{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "vmd"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "rtsx_usb_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  fileSystems."/nix/store" = {
    device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
    fsType = "btrfs";
    options = [ "subvol=@nix" ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
    fsType = "btrfs";
    options = [ "subvol=@log" ];
  };

  fileSystems."/var/cache" = {
    device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
    fsType = "btrfs";
    options = [ "subvol=@cache" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/90B1-1F4B";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/52b32533-3831-4659-b24b-06614e4e9e35"; }
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

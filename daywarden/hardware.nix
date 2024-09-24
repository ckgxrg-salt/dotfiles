# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

  fileSystems."/nix/store" =
    { device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };

  fileSystems."/var/cache" =
    { device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
      fsType = "btrfs";
      options = [ "subvol=@cache" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/90B1-1F4B";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/52b32533-3831-4659-b24b-06614e4e9e35"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

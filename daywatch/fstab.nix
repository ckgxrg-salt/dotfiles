{
  modulesPath,
  ...
}:
#========== Filesystem ==========#
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

    "/nix/store" = {
      device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

    "/var/log" = {
      device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };

    "/var/cache" = {
      device = "/dev/disk/by-uuid/4475d92b-fa6e-4b0f-9aef-d9dd6e49a67a";
      fsType = "btrfs";
      options = [ "subvol=@cache" ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/90B1-1F4B";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  };
  # Swap
  swapDevices = [
    { device = "/dev/disk/by-uuid/52b32533-3831-4659-b24b-06614e4e9e35"; }
  ];
}

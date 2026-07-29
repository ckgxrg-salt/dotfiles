{ lib, ... }:
let
  mkSubvol =
    name: value:
    value
    // {
      device = "/dev/disk/by-partlabel/disk-nvme-root";
      fsType = "btrfs";
      options = [
        "compress=zstd"
        "noatime"
        "subvol=${name}"
      ];
    };
in
{
  fileSystems = {
    "esp" = {
      device = "/dev/disk/by-partlabel/disk-nvme-esp";
      fsType = "vfat";
      mountPoint = "/boot";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
  }
  // (lib.attrsets.mapAttrs mkSubvol {
    "rootfs".mountPoint = "/";
    "home".mountPoint = "/home";
    "var".mountPoint = "/var";
    "nix".mountPoint = "/nix";
    "games".mountPoint = "/home/ckgxrg/Games";
  });

  swapDevices = [
    {
      device = "/dev/disk/by-partlabel/disk-nvme-swap";
    }
  ];
}

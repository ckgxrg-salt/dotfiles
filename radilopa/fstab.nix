{ ... }:
#========== Filesystem ==========#
{
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/FF2D-AAA9";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    "/" = {
      device = "/dev/disk/by-uuid/665935e0-b8e5-4012-9130-4eecf0f56a12";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    "/home" = {
      device = "/dev/disk/by-uuid/c85d7703-1ef0-4845-9fee-708c2439f11b";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/c85d7703-1ef0-4845-9fee-708c2439f11b";
      fsType = "btrfs";
      options = [ "subvol=@nix" ];
    };

    "/win/C:" = {
      device = "/dev/disk/by-uuid/1C64A5BB64A597D2";
      fsType = "ntfs3";
      options = [
        "rw"
        "uid=1000"
        "windows_names"
        "nofail"
      ];
    };

    "/win/D:" = {
      device = "/dev/disk/by-uuid/2818AFD018AF9AF8";
      fsType = "ntfs3";
      options = [
        "rw"
        "uid=1000"
        "windows_names"
        "nofail"
      ];
    };

    "/var/log" = {
      device = "/dev/disk/by-uuid/c85d7703-1ef0-4845-9fee-708c2439f11b";
      fsType = "btrfs";
      options = [ "subvol=@log" ];
    };

    "/var/cache" = {
      device = "/dev/disk/by-uuid/c85d7703-1ef0-4845-9fee-708c2439f11b";
      fsType = "btrfs";
      options = [ "subvol=@cache" ];
    };
  };
  # Swap
  swapDevices = [ { device = "/dev/disk/by-uuid/1715a135-79bf-4c19-9b3e-80645997d8d8"; } ];
}

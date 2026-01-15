{ ... }:
{
  disko.devices.disk = {
    "nvme" = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          "esp" = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "fmask=0022"
                "dmask=0022"
              ];
            };
          };
          "swap" = {
            size = "38G";
            content = {
              type = "swap";
            };
          };
          "root" = {
            size = "100%";
            content = {
              type = "btrfs";
              subvolumes =
                let
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                in
                {
                  "rootfs" = {
                    inherit mountOptions;
                    mountpoint = "/";
                  };
                  "rootfs/.snapshots" = {
                    inherit mountOptions;
                    mountpoint = "/.snapshots";
                  };

                  "home" = {
                    inherit mountOptions;
                    mountpoint = "/home";
                  };
                  "home/.snapshots" = {
                    inherit mountOptions;
                    mountpoint = "/home/.snapshots";
                  };

                  "var" = {
                    inherit mountOptions;
                    mountpoint = "/var";
                  };
                  "var/.snapshots" = {
                    inherit mountOptions;
                    mountpoint = "/var/.snapshots";
                  };

                  "nix" = {
                    inherit mountOptions;
                    mountpoint = "/nix";
                  };

                  # For exclusion of large game files from backups
                  "games" = {
                    inherit mountOptions;
                    mountpoint = "/home/ckgxrg/Games";
                  };
                  "games/.snapshots" = {
                    inherit mountOptions;
                    mountpoint = "/home/ckgxrg/Games/.snapshots";
                  };
                };
            };
          };
        };
      };
    };
  };
}

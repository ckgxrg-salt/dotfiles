{ ... }:
{
  disko.devices.disk = {
    "nvme" = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          "ESP" = {
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
          "Swap" = {
            size = "38G";
            content = {
              type = "swap";
            };
          };
          "Root" = {
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
                  "root" = {
                    inherit mountOptions;
                    mountpoint = "/";
                  };
                  "home" = {
                    inherit mountOptions;
                    mountpoint = "/home";
                  };
                  "var" = {
                    inherit mountOptions;
                    mountpoint = "/var";
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
                };
            };
          };
        };
      };
    };
  };
}

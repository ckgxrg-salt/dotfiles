# Entrypoint for all os modules
{ config, lib, ... }:
{
  imports = [
    ./boot
    ./boot/limine.nix
    ./boot/plymouth.nix

    ./login/users.nix
    ./login/greetd.nix

    ./hardware
    ./hardware/audio.nix
    ./hardware/btrfs.nix
    ./hardware/graphics.nix
    ./hardware/network.nix

    ./programs/gamemode.nix
    ./programs/nix.nix
    ./programs/openrgb.nix
    ./programs/steam.nix
    ./programs/tailscale.nix
    ./programs/tuned.nix
    ./programs/thermald.nix
    ./programs/wivrn.nix

    ./misc/locale.nix
    ./misc/misc.nix
    ./misc/security.nix

    ./theme/stylix.nix
  ];

  # Device attributes
  options.device = {
    hostname = lib.mkOption {
      type = lib.types.str;
      description = "Hostname for the device";
    };
    laptop = lib.mkEnableOption "Whether this is a laptop";
    version = lib.mkOption {
      type = lib.types.str;
      description = "NixOS version";
    };
    hostCPU = lib.mkOption {
      type = lib.types.enum [
        "intel"
        "amd"
      ];
      description = "The host's CPU manufacturer";
    };
    hostGPU = lib.mkOption {
      type = lib.types.enum [
        "intel"
        "amd"
        "nvidia"
      ];
      description = "The host's GPU manufacturer";
    };
  };

  config = {
    networking.hostName = config.device.hostname;
    system.stateVersion = config.device.version;
  };
}

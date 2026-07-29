{ ... }:
{
  imports = [
    ./boot
    ./boot/limine.nix
    ./boot/plymouth.nix

    ./login/users.nix
    ./login/greetd.nix
    ./login/howdy.nix
    ./login/u2f.nix

    ./device
    ./device/audio.nix
    ./device/btrfs.nix
    ./device/graphics.nix
    ./device/network.nix

    ./development/podman.nix

    ./programs/mihomo.nix
    ./programs/gamemode.nix
    ./programs/nix.nix
    ./programs/openrgb.nix
    ./programs/speechd.nix
    ./programs/steam.nix
    ./programs/tuned.nix
    ./programs/thermald.nix
    ./programs/wivrn.nix
    ./programs/netbird.nix

    ./misc/locale.nix
    ./misc/misc.nix
    ./misc/security.nix

    ./theme/cursor.nix
    ./theme/fonts.nix
    ./theme/icons.nix
  ];
}

{ ... }:
# Entrypoint for all os modules
{
  imports = [
    ./boot

    ./login/users.nix
    ./login/greetd.nix

    ./hardware
    ./hardware/btrfs.nix
    ./hardware/zfs.nix

    ./programs/gamemode.nix
    ./programs/nix.nix
    ./programs/openrgb.nix
    ./programs/steam.nix
    ./programs/tailscale.nix
    ./programs/wivrn.nix

    ./misc/locale.nix
    ./misc/misc.nix
    ./misc/security.nix

    ./theme/fonts.nix
    ./theme/stylix.nix
    ./theme/sound-theme.nix
  ];
}

{ ... }:
# Entrypoint for all os modules
{
  imports = [
    ./boot

    ./login/users.nix
    ./login/greetd.nix

    ./hardware
    ./hardware/zfs.nix

    ./apps/gamemode.nix
    ./apps/nix.nix
    ./apps/openrgb.nix
    ./apps/steam.nix
    ./apps/tailscale.nix
    ./apps/wivrn.nix

    ./misc/locale.nix
    ./misc/misc.nix
    ./misc/security.nix

    ./theme/fonts.nix
    ./theme/stylix.nix
    ./theme/sound-theme.nix
  ];
}

{ ... }:
# Entrypoint for all os modules
{
  imports = [
    ./boot

    ./login/users.nix
    ./login/greetd.nix

    ./hardware

    ./apps/gamemode.nix
    ./apps/nix.nix
    ./apps/openrgb.nix
    ./apps/steam.nix
    ./apps/wivrn.nix

    ./misc/locale.nix
    ./misc/misc.nix
    ./misc/security.nix

    ./theme/stylix.nix
    ./theme/sound-theme.nix
  ];
}

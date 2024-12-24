{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./sddm.nix
    ./userspace.nix
    ./nix.nix
    ../shared/security.nix
    ../shared/dev/podman.nix

    ./gaming/gamemode.nix
    ../shared/gaming/steam.nix
    ../shared/gaming/wivrn.nix
    ../shared/gaming/sunshine.nix
  ];

  # Hostname
  networking.hostName = "Radilopa";

  system.stateVersion = "23.11";
}

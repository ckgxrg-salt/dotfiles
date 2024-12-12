{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./sddm.nix
    ./userspace.nix
    ./nix.nix
    ../generals/security.nix
    ../generals/apps/steam.nix
    ../generals/dev/podman.nix
    ../generals/sunshine
  ];

  # My Name!
  networking.hostName = "Radilopa";

  system.stateVersion = "23.11";
}

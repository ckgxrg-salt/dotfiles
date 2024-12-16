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
    ../generals/dev/podman.nix

    ../generals/gaming/steam.nix
    ../generals/gaming/wivrn.nix
    ../generals/gaming/sunshine.nix
  ];

  # My Name!
  networking.hostName = "Radilopa";

  system.stateVersion = "23.11";
}

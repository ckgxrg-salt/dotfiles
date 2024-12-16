{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./greetd.nix
    ./userspace.nix
    ./nix.nix
    ../generals/security.nix
    ../generals/gaming/steam.nix
  ];

  # Hostname
  networking.hostName = "Daywatch";

  system.stateVersion = "24.05";
}

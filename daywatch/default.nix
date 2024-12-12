{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./greetd.nix
    ./userspace.nix
    ./nix.nix
    ../generals/apps/steam.nix
    ../generals/security.nix
  ];

  # Hostname
  networking.hostName = "Daywatch";

  system.stateVersion = "24.05";
}

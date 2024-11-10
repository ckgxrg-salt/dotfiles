{ ... }:
# Master configuration for Radilopa
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./package.nix
    ../generals/security.nix
    ../generals/dev/podman.nix
    ../generals/sunshine
    ../generals/utils/steam.nix
  ];

  # My Name!
  networking.hostName = "Radilopa";

  system.stateVersion = "23.11";
}

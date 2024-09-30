{ ... }:
# Master configuration for Radilopa
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./package.nix
    ./security.nix
    ../generals/dev/podman.nix
    ../generals/sunshine
    ../generals/utils/steam.nix
  ];

  system.stateVersion = "23.11";
}

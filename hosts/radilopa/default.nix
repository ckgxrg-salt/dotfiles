{ config, ... }:
# Master configuration for Radilopa
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./package.nix
    ../../modules/podman
    ../../modules/sunshine
  ];

  system.stateVersion = "23.11";
}

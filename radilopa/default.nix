{ config, ... }:
# Master configuration for Radilopa
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./package.nix
    ../modules/dev/podman.nix
    ../modules/sunshine
    ../modules/utils/steam.nix
  ];

  system.stateVersion = "23.11";
}

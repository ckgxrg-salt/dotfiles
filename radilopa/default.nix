{ ... }:
# Master configuration for Radilopa
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./package.nix
    ./security.nix
    ../modules/dev/podman.nix
    ../modules/sunshine
    ../modules/utils/steam.nix
  ];

  system.stateVersion = "23.11";
}

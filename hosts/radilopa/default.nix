{ inputs, pkgs, config, flatpak, ... }:
# Master configuration for Radilopa
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./package.nix
  ];

  system.stateVersion = "23.11";
}

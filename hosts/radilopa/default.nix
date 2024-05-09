{ inputs, pkgs, config, flatpak, ... }:
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./package.nix
    ../../modules/flatpak
  ];

  system.stateVersion = "23.11";
}

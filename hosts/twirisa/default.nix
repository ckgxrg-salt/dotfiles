{ inputs, pkgs, config, flatpak, ... }:
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./package.nix
    ../../modules/podman
  ];

  system.stateVersion = "23.11";
}

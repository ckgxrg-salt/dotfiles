{ config, ... }:
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./package.nix
    ../../modules/podman
  ];

  system.stateVersion = "24.05";
}

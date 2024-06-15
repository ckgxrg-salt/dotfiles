{ config, ... }:
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./syscfg.nix
    ./package.nix
    ../modules/dev/podman.nix
  ];

  system.stateVersion = "24.05";
}

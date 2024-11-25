{ ... }:
{
  imports = [
    ./boot.nix
    ./peripheral.nix
    ./login.nix
    ./package.nix
    ./misc.nix
    ../generals/dev/podman.nix
    ../generals/utils/steam.nix
    ../generals/security.nix
  ];

  # My Name!
  networking.hostName = "Daywatch";

  system.stateVersion = "24.05";
}

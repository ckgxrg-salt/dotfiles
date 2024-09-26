{ ... }:
{
  imports = [
    ./boot.nix
    ./peripheral.nix
    ./login.nix
    ./security.nix
    ./package.nix
    ./misc.nix
    ../generals/dev/podman.nix
    ../generals/utils/steam.nix
  ];

  # My Name!
  networking.hostName = "Daywarden";

  system.stateVersion = "24.05";
}

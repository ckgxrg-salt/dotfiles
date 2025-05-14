{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./common.nix
    ./greetd.nix
    ./nix.nix
    ../shared/security.nix
    ../shared/gaming/steam.nix
  ];

  # Hostname
  networking.hostName = "Daywatch";

  system.stateVersion = "24.05";
}

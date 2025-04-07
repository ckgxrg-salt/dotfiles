{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./disko.nix
    ./hardware.nix
    ./common.nix
    ./greetd.nix
    ./nix.nix
    ../shared/security.nix
    ../shared/gaming/steam.nix
  ];

  # Hostname
  networking = {
    hostName = "Vistath";
    hostId = "7811019c";
  };

  system.stateVersion = "24.11";
}

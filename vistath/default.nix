{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./disko.nix
    ./configuration.nix
    ./greetd.nix
    ./nix.nix
    ../shared/commons.nix
    ../shared/security.nix
    ../shared/utils/firejail.nix
    ../shared/gaming/steam.nix
  ];

  # Hostname
  networking = {
    hostName = "Vistath";
    hostId = "7811019c";
  };

  system.stateVersion = "24.11";
}

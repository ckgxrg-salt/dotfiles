{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./configuration.nix
    ./greetd.nix
    ./nix.nix
    ../shared/commons.nix
    ../shared/security.nix
    ../shared/utils/firejail.nix
    ../shared/gaming/steam.nix
  ];

  # Hostname
  networking.hostName = "Daywatch";

  system.stateVersion = "24.05";
}

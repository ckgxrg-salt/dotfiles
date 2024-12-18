{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./greetd.nix
    ./userspace.nix
    ./nix.nix
    ../shared/security.nix
    ../shared/gaming/steam.nix
    ../shared/gaming/gamemode.nix
  ];

  # Hostname
  networking.hostName = "Daywatch";

  system.stateVersion = "24.05";
}

{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./configuration.nix
    ./sddm.nix
    ./nix.nix
    ../shared/security.nix
    ../shared/util/firejail.nix

    ./gaming/gamemode.nix
    ../shared/gaming/alvr.nix
    ../shared/gaming/steam.nix
    ../shared/gaming/wivrn.nix
    ../shared/gaming/sunshine.nix
  ];

  # Hostname
  networking.hostName = "Radilopa";

  system.stateVersion = "23.11";
}

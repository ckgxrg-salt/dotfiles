{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./configuration.nix
    ./sddm.nix
    ./nix.nix
    ../shared/commons.nix
    ../shared/security.nix
    ../shared/utils/firejail.nix

    ../shared/gaming/alvr.nix
    ../shared/gaming/steam.nix
    ../shared/gaming/wivrn.nix
    ../shared/gaming/sunshine.nix
  ];

  # Hostname
  networking.hostName = "Radilopa";

  system.stateVersion = "23.11";
}

{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./common.nix
    ./nix.nix
    ./sddm.nix
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

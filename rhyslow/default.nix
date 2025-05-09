{ ... }:
# Entrypoint
{
  imports = [
    ./boot.nix
    ./disko.nix
    ./greetd.nix
    ./hardware.nix
    ./common.nix
    ./nix.nix

    ../shared/security.nix
    ../shared/gaming/openrgb.nix
    ../shared/gaming/steam.nix
    ../shared/gaming/sunshine.nix
  ];

  # Hostname
  networking = {
    hostName = "Rhyslow";
    hostId = "aa2caad5";
  };

  system.stateVersion = "25.05";
}

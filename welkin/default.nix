{ ... }:
# Host entrypoint
{
  imports = [
    ./boot.nix
    ./login.nix
    ./settings.nix
    ./security.nix
  ];

  # Hostname
  networking.hostName = "Welkin";

  system.stateVersion = "25.05";
}

{ ... }:
# This vm runs miscellaneous services
{
  imports = [
    ./login.nix
    ./security.nix
    ./settings.nix
  ];

  # Hostname & Host ID
  networking = {
    hostName = "Everpivot";
    hostId = "f058329f";
  };

  system.stateVersion = "24.11";
}

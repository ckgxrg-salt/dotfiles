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
    hostName = "Welkin-Common";
    hostId = "f058329f";
  };

  # microvm options
  microvm = {
    guest.enable = true;
    hypervisor = "cloud-hypervisor";
    interfaces = [
      {
        type = "tap";
        id = "vm-0";
        mac = "2C:B3:7A:AC:AD:AA";
      }
    ];
    shares = [
      {
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
        tag = "ro-store";
        proto = "virtiofs";
      }
    ];
  };

  system.stateVersion = "24.11";
}

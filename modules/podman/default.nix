{ pkgs, config, ... }:
# Podman configurations for containers
{
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable  = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  users.users.ckgxrg.extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [
    dive
    distrobox
  ];
}
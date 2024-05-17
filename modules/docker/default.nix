{ pkgs, config, inputs, ... }:
{
  virtualisation.docker = {
    enable  = true;
    rootless.enable = true;
    rootless.setSocketVariable = true;
    storageDriver = "btrfs";
  };
  users.users.ckgxrg.extraGroups = [ "docker" ];
  environment.systemPackages = [ pkgs.distrobox ];
}
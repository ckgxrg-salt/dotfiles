{ config, lib, ... }:
let
  cfg = config.development.podman;
in
{
  options.development.podman = {
    enable = lib.mkEnableOption "Enable default Podman settings";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.containers.enable = true;
    virtualisation.podman = {
      enable = true;
    };

    hardware.nvidia-container-toolkit.enable = lib.mkIf (config.device.hostGPU == "nvidia") true;

    users.users."ckgxrg" = {
      extraGroups = [ "podman" ];
      subUidRanges = [
        {
          count = 65536;
          startUid = 100000;
        }
      ];
      subGidRanges = [
        {
          count = 65536;
          startGid = 100000;
        }
      ];
    };
  };
}

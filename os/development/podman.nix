{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.development.podman;
in
{
  options.development.podman = {
    enable = mkEnableOption "Enable default Podman settings";
  };

  config = mkIf cfg.enable {
    virtualisation.containers.enable = true;
    virtualisation.podman = {
      enable = true;
    };

    hardware.nvidia-container-toolkit.enable = mkIf (config.device.hostGPU == "nvidia") true;

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

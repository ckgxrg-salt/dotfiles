{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.hardware;
in
{
  options.hardware = {
    hostGPU = mkOption {
      type = types.enum [
        "intel"
        "amd"
        "nvidia"
      ];
      description = "The host's GPU manufacturer";
    };
  };

  config = mkIf cfg.default {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages =
        with pkgs;
        [
          libva-vdpau-driver
        ]
        ++ optionals (cfg.hostGPU == "intel") [
          intel-media-driver
          intel-compute-runtime
        ]
        ++ optionals (cfg.hostGPU == "nvidia") [
          nvidia-vaapi-driver
        ];
      extraPackages32 =
        with pkgs.driversi686Linux;
        [
          libva-vdpau-driver
        ]
        ++ optionals (cfg.hostGPU == "intel") [
          intel-media-driver
        ];
    };

    services.xserver = mkIf (cfg.hostGPU == "nvidia") {
      videoDrivers = [ "nvidia" ];
    };
    hardware.nvidia = mkIf (cfg.hostGPU == "nvidia") {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      open = true;
    };
  };
}

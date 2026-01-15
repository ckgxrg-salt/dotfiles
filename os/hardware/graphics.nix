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
  config = mkIf cfg.default {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages =
        with pkgs;
        [
          libva-vdpau-driver
        ]
        ++ optionals (config.device.hostGPU == "intel") [
          intel-media-driver
          intel-compute-runtime
        ]
        ++ optionals (config.device.hostGPU == "nvidia") [
          nvidia-vaapi-driver
        ];
      extraPackages32 =
        with pkgs.driversi686Linux;
        [
          libva-vdpau-driver
        ]
        ++ optionals (config.device.hostGPU == "intel") [
          intel-media-driver
        ];
    };

    services.xserver = mkIf (config.device.hostGPU == "nvidia") {
      videoDrivers = [ "nvidia" ];
    };
    hardware.nvidia = mkIf (config.device.hostGPU == "nvidia") {
      package = config.boot.kernelPackages.nvidiaPackages.production;
      open = true;
    };
  };
}

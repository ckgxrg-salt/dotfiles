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
        optionals (config.device.hostGPU == "intel") [
          intel-media-driver
          vpl-gpu-rt
          intel-compute-runtime
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

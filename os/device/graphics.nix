{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.device = {
    hostGPU = lib.mkOption {
      type = lib.types.enum [
        "intel"
        "amd"
        "nvidia"
      ];
      description = "The host's GPU manufacturer";
    };
  };

  config = {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages =
        with pkgs;
        lib.optionals (config.device.hostGPU == "intel") [
          intel-media-driver
          vpl-gpu-rt
          intel-compute-runtime
        ]
        ++ lib.optionals (config.device.hostGPU == "nvidia") [
          nvidia-vaapi-driver
        ];
    };

    services.xserver = lib.mkIf (config.device.hostGPU == "nvidia") {
      videoDrivers = [ "nvidia" ];
    };
    hardware.nvidia = lib.mkIf (config.device.hostGPU == "nvidia") {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      open = true;
    };
  };
}

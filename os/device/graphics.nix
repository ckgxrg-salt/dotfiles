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
    boot.initrd.kernelModules =
      lib.optionals (config.device.hostGPU == "amd") [ "amdgpu" ]
      ++ lib.optionals (config.device.hostGPU == "intel") [ "xe" ]
      ++ lib.optionals (config.device.hostGPU == "nvidia") [
        "nvidia"
        "nvidia_modeset"
        "nvidia_drm"
      ];

    boot.kernelParams = lib.optionals (config.device.hostGPU == "nvidia") [
      "nvidia_drm.modeset=1"
    ];

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
      open = true;
      branch = "bleeding_edge";
    };
  };
}

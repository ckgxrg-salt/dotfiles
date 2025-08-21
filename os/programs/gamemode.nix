{
  config,
  lib,
  pkgs,
  ...
}:
# Gamemode and Gamescope
with lib;
let
  cfg = config.program.gamemode;
in
{
  options.program.gamemode = {
    enable = mkEnableOption "Enable Gamemode and Gamescope";
    overclock = mkEnableOption "Let Gamemode apply radical GPU policies";
  };

  config = mkIf cfg.enable {
    programs.gamemode = {
      enable = true;
      enableRenice = true;
      settings = {
        gpu = mkIf cfg.overclock {
          gpu_device = 1;
          apply_gpu_optimisations = "accept-responsibility";
          nv_powermizer_mode = 0;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send -i input-gamepad 'GameMode Active'";
        };
      };
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
      env = mkIf (config.hardware.hostGPU == "nvidia") {
        __NV_PRIME_RENDER_OFFLOAD = "1";
        __VK_LAYER_NV_optimus = "NVIDIA_only";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
    };
  };
}

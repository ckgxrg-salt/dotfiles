{ ... }:
# Radilopa specific
{
  imports = [ ../../shared/gaming/gamemode.nix ];

  programs.gamemode = {
    settings = {
      gpu = {
        gpu_device = 1;
        apply_gpu_optimisations = "accept-responsibility";
        nv_powermizer_mode = 0;
      };
    };
  };

  programs.gamescope = {
    env = {
      __NV_PRIME_RENDER_OFFLOAD = "1";
      __VK_LAYER_NV_optimus = "NVIDIA_only";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}

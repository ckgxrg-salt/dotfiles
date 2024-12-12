{ ... }:
# User environment variables
{
  xdg.configFile = {
    # General environment
    "uwsm/env".text = ''
      export LIBVA_DRIVER_NAME=nvidia
      export GBM_BACKEND=nvidia-drm
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export NVD_BACKEND=direct
      export ELECTRON_OZONE_PLATFORM_HINT=auto
      export NIXOS_OZONE_WL=1
      export ELM_DISPLAY=wl
      export SDL_VIDEODRIVER=wayland
    '';

    # Hyprland-specific
    "uwsm/env-hyprland".text = '''';
  };
}

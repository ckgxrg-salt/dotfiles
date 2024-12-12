{ ... }:
# User environment variables
{
  xdg.configFile = {
    # General environment
    "uwsm/env".text = ''
      export ELECTRON_OZONE_PLATFORM_HINT=auto;
      export NIXOS_OZONE_WL=1;
      export ELM_DISPLAY=wl;
      export SDL_VIDEODRIVER=wayland;
    '';

    # Hyprland-specific
    "uwsm/env-hyprland".text = '''';
  };
}

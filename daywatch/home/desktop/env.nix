{ ... }:
# User environment variables
{
  xdg.configFile = {
    # General environment
    "uwsm/env".text = ''
      export ELECTRON_OZONE_PLATFORM_HINT=auto
      export NIXOS_OZONE_WL=1
      export ELM_DISPLAY=wl
      export SDL_VIDEODRIVER=wayland

      export HISTFILE=$XDG_STATE_HOME/bash/history
      export CARGO_HOME=$XDG_DATA_HOME/cargo
      export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
      export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
      export W3M_DIR=$XDG_DATA_HOME/w3m
    '';
  };
}

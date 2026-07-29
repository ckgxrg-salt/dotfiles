{ config, ... }:
{
  config = {
    home.sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = 1;
      ELM_DISPLAY = "wl";
      SDL_VIDEODRIVER = "wayland";

      HISTFILE = "${config.xdg.stateHome}/bash/history";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
      GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
    };
  };
}

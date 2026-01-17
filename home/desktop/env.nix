{ config, lib, ... }:
with lib;
let
  cfg = config.desktop.sessionVars;
in
{
  options.desktop.sessionVars = {
    default = mkEnableOption "Set default session variables";
    extraVars = mkOption {
      default = { };
      description = "Extra session variables";
      type =
        with types;
        attrsOf (
          nullOr (oneOf [
            int
            str
          ])
        );
    };
  };

  config = {
    home.sessionVariables =
      optionalAttrs cfg.default {
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        NIXOS_OZONE_WL = 1;
        ELM_DISPLAY = "wl";
        SDL_VIDEODRIVER = "wayland";

        HISTFILE = "${config.xdg.stateHome}/bash/history";
        CARGO_HOME = "${config.xdg.dataHome}/cargo";
        GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
      }
      // cfg.extraVars;
  };
}

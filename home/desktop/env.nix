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
      apply = mapAttrsToList (k: v: ''export ${k}=${toString v}'');
    };
  };

  config = {
    xdg.configFile = {
      "uwsm/env".text =
        mkIf cfg.default ''
          export ELECTRON_OZONE_PLATFORM_HINT=auto
          export NIXOS_OZONE_WL=1
          export ELM_DISPLAY=wl
          export SDL_VIDEODRIVER=wayland

          export HISTFILE=$XDG_STATE_HOME/bash/history
          export CARGO_HOME=$XDG_DATA_HOME/cargo
          export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
          export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc
          export W3M_DIR=$XDG_DATA_HOME/w3m
        ''
        + concatStringsSep "\n" cfg.extraVars;
    };
  };
}

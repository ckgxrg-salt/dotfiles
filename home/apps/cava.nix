{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.cava;
in
{
  options.apps.cava = mkEnableOption "Enable CAVA audio visualiser";

  config = mkIf cfg {
    # cava itself
    programs.cava = {
      enable = true;
      settings = {
        general = {
          framerate = 30;
          sensitivity = 50;
          bar_width = 6;
          sleep_timer = 10;
        };
        # Only PipeWire is enough
        input = {
          method = "pipewire";
          source = "auto";
        };
        output = {
          waveform = 0;
          show_idle_bar_heads = 0;
        };
      };
    };

    # WM needs to wrap it
    wayland.windowManager.hyprland.settings.windowrulev2 = [
      "noanim, class:(alacritty-cava)"
      "nodim, class:(alacritty-cava)"
      "noblur, class:(alacritty-cava)"
      "noshadow, class:(alacritty-cava)"
      "noborder, class:(alacritty-cava)"
      "nofocus, class:(alacritty-cava)"
      "float, class:(alacritty-cava)"
    ];

    # Wrap cava in alacritty for use of hyprwinwrap
    systemd.user.services."cava" =
      let
        alacritty-cava-cfg = pkgs.writeText "alacritty-cava-cfg.toml" ''
          [window]
          decorations = "None"
          opacity = 0.0
        '';
      in
      {
        Unit = {
          Description = "C.A.V.A. the Audio Visualiser";
          Requires = [ "graphical-session.target" ];
        };
        Service = {
          Type = "exec";
          ExecStart = ''
            ${pkgs.alacritty}/bin/alacritty \
                  --class "alacritty-cava" \
                  --title "C.A.V.A." \
                  --config-file ${alacritty-cava-cfg} \
                  --command ${pkgs.cava}/bin/cava
          '';
          Restart = "no";
          Slice = "app-graphical.slice";
        };
      };
  };
}

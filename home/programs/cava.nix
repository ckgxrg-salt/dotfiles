{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.cava;
in
{
  options.program.cava = {
    enable = mkEnableOption "Enable CAVA audio visualiser";
  };

  config = mkIf cfg.enable {
    stylix.targets.cava = {
      enable = true;
      rainbow.enable = true;
    };

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
    wayland.windowManager.hyprland.settings.windowrule = [
      {
        name = "cava-props";
        "match:class" = "cava";
        no_anim = "on";
        no_dim = "on";
        no_blur = "on";
        no_shadow = "on";
        no_focus = "on";
        border_size = 0;
        float = "on";
        pin = "on";
      }
    ];

    systemd.user.services."cava" = {
      Unit = {
        Description = "C.A.V.A. the Audio Visualiser";
        Requires = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart =
          let
            alacritty-cava-cfg = pkgs.writeText "alacritty-cava.toml" ''
              [window]
              decorations = "None"
              opacity = 0.0
            '';
          in
          ''
            ${config.programs.alacritty.package}/bin/alacritty \
              --class "cava" \
              --title "C.A.V.A." \
              --config-file ${alacritty-cava-cfg} \
              --command cava
          '';
        Restart = "no";
      };
    };
  };
}

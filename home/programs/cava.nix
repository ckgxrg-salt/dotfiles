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
    wayland.windowManager.hyprland.settings.windowrule = [
      {
        name = "cava-props";
        "match:class" = "ghostty.cava";
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
        ExecStart = ''
          ${config.programs.ghostty.package}/bin/ghostty \
            --class="ghostty.cava" \
            --title="C.A.V.A." \
            --window-decoration="none" \
            --background-opacity=0 \
            -e cava
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

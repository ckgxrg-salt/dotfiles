{ pkgs, ... }:
# C.A.V.A. the Audio Visualiser
{
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
      color = {
        # Use everforest color scheme
        gradient = 1;
        gradient_color_1 = "'#a6b0a0'";
        gradient_color_2 = "'#93b259'";
        gradient_color_3 = "'#a7c080'";
        gradient_color_4 = "'#7fbbb3'";
        gradient_color_5 = "'#829181'";
        gradient_color_6 = "'#8da101'";
        gradient_color_7 = "'#83c092'";
        gradient_color_8 = "'#7a8478'";
      };
    };
  };

  # WM needs to wrap it
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "workspace name:Dashboard silent, class:(alacritty-cava)"
      "noanim, class:(alacritty-cava)"
      "nodim, class:(alacritty-cava)"
      "noblur, class:(alacritty-cava)"
      "nofocus, class:(alacritty-cava)"
      "float, class:(alacritty-cava)"
      "size 1920 540, class:(alacritty-cava)"
    ];
  };

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
}

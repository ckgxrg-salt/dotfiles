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
        # Use rose-pine color scheme
        gradient = 1;
        gradient_count = 6;
        gradient_color_1 = "'#3e8fb0'";
        gradient_color_2 = "'#9ccfd8'";
        gradient_color_3 = "'#c4a7e7'";
        gradient_color_4 = "'#ea9a97'";
        gradient_color_5 = "'#f6c177'";
        gradient_color_6 = "'#eb6f92'";
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
      "size 1920 515, class:(alacritty-cava)"
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

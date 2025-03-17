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
        gradient_color_1 = "'#425047'";
        gradient_color_2 = "'#A7C080'";
        gradient_color_3 = "'#A7C080'";
        gradient_color_4 = "'#83C092'";
        gradient_color_5 = "'#7FBBB3'";
        gradient_color_6 = "'#DBBC7F'";
        gradient_color_7 = "'#E69875'";
        gradient_color_8 = "'#E67E80'";
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
    "monitor DP-1, class:(alacritty-cava)"
    "opacity 0.6, class:(alacritty-cava)"
    "float, class:(alacritty-cava)"
    "size 1920 500, class:(alacritty-cava)"
    "move 0 15, class:(alacritty-cava)"
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
}

{
  config,
  pkgs,
  ckgs,
  ...
}:
{
  # Rofi
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    cycle = true;
    location = "top-right";
    plugins = with pkgs; [
      rofi-emoji-wayland
    ];
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "${ckgs.rofi-themes}/config/rofi/launchers/type-3/style-1.rasi";
    extraConfig = {
      show-icons = true;
      icon-theme = config.theme.icon.name;
      run-command = "uwsm app -- {cmd}";
    };
  };
}

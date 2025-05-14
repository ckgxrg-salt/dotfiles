{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.rofi;
in
{
  options.apps.rofi = {
    enable = mkEnableOption "Enable Rofi";
    theme = mkOption {
      type = types.str;
      description = "Rofi theme to be used";
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      cycle = true;
      location = "top-right";
      plugins = with pkgs; [
        rofi-emoji-wayland
      ];
      terminal = "${pkgs.alacritty}/bin/alacritty";
      theme = cfg.theme;
      extraConfig = {
        show-icons = true;
        icon-theme = config.theme.icon.name;
        run-command = "uwsm app -- {cmd}";
      };
    };
  };
}

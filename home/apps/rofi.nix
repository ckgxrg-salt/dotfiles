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
      terminal = "${pkgs.alacritty}/bin/alacritty";
      theme = lib.mkForce cfg.theme;
      extraConfig = {
        show-icons = true;
        run-command = "uwsm app -- {cmd}";
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.program.rofi;
in
{
  options.program.rofi = {
    enable = mkEnableOption "Enable Rofi";
    theme = mkOption {
      type = types.str;
      description = "Rofi theme to be used";
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      cycle = true;
      terminal = "${pkgs.alacritty}/bin/alacritty";
      theme = lib.mkForce cfg.theme;
      extraConfig = {
        show-icons = true;
      };
    };
  };
}

{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.program.vicinae;
in
{
  options.program.vicinae = {
    enable = mkEnableOption "Enable Vicinae";
  };

  config = mkIf cfg.enable {
    stylix.targets.vicinae.enable = true;

    programs.vicinae = {
      enable = true;
      systemd = {
        enable = true;
      };
    };

    wayland.windowManager.hyprland.settings.layerrule = [
      {
        name = "vicinae-blur";
        "match:namespace" = "vicinae";
        blur = "on";
        ignore_alpha = 0;
      }
    ];
  };
}

{
  osConfig,
  config,
  lib,
  ...
}:
let
  cfg = config.program.vicinae;
in
{
  options.program.vicinae = {
    enable = lib.mkEnableOption "Enable Vicinae";
  };

  config = lib.mkIf cfg.enable {
    theme.matugen.templates.vicinae = {
      input_path = ../theme/templates/vicinae-theme.toml;
      output_path = "${config.xdg.dataHome}/vicinae/themes/matugen.toml";
    };

    programs.vicinae = {
      enable = true;
      systemd = {
        enable = true;
      };
      settings = {
        theme = {
          dark.name = "matugen";
          light.name = "matugen";
        };
        font.normal = {
          family = osConfig.theme.fonts.name;
          size = osConfig.theme.fonts.sizes.popups;
        };
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

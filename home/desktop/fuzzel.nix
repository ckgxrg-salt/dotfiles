{
  osConfig,
  config,
  lib,
  ...
}:
let
  cfg = config.desktop.fuzzel;
in
{
  options.desktop.fuzzel = {
    enable = lib.mkEnableOption "Enable Fuzzel";
  };

  config = lib.mkIf cfg.enable {
    theme.matugen.templates.fuzzel = {
      input_path = ../theme/templates/fuzzel-colors.ini;
      output_path = "${config.xdg.configHome}/fuzzel/colors.ini";
    };

    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          include = "~/.config/fuzzel/colors.ini";
          font = "${osConfig.theme.fonts.name}:size=${toString osConfig.theme.fonts.sizes.popups}";
          dpi-aware = "no";
          terminal = "kitty";
        };
      };
    };
  };
}

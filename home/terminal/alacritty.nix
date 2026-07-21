{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.terminal.alacritty;
in
{
  options.terminal.alacritty = {
    enable = mkEnableOption "Enable default Alacritty settings";
  };

  config = mkIf cfg.enable {
    theme.matugen.templates.alacritty = {
      input_path = ../theme/templates/alacritty-theme.toml;
      output_path = "${config.xdg.configHome}/alacritty/theme.toml";
    };

    programs.alacritty = {
      enable = true;
      settings = {
        general.import = [ "theme.toml" ];
        window = {
          opacity = 1.0;
          blur = true;
          decorations_theme_variant = "Dark";
          padding = {
            x = 18;
            y = 18;
          };
        };
      };
    };
  };
}

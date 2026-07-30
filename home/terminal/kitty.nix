{
  osConfig,
  config,
  lib,
  ...
}:
let
  cfg = config.terminal.kitty;
in
{
  options.terminal.kitty = {
    enable = lib.mkEnableOption "Enable default Kitty settings";
  };

  config = lib.mkIf cfg.enable {
    theme.matugen.templates.kitty = {
      input_path = ../theme/templates/kitty-colors.conf;
      output_path = "${config.xdg.configHome}/kitty/colors.conf";
    };

    programs.kitty = {
      enable = true;
      shellIntegration.enableBashIntegration = true;
      font = {
        name = osConfig.theme.fonts.monospace;
        size = osConfig.theme.fonts.sizes.terminal;
      };
      extraConfig = ''
        map ctrl+shift+h
        map ctrl+shift+l

        include colors.conf
      '';
    };
  };
}

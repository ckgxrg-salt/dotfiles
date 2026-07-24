{ config, lib, ... }:
with lib;
let
  cfg = config.program.btop;
in
{
  options.program.btop = {
    enable = mkEnableOption "Enable btop system monitor";
  };

  config = mkIf cfg.enable {
    theme.matugen.templates.btop = {
      input_path = ../theme/templates/btop.theme;
      output_path = "${config.xdg.configHome}/btop/themes/matugen.theme";
    };

    programs.btop = {
      enable = true;
      settings = {
        color_theme = "matugen";
        vim_keys = true;
      };
    };
  };
}

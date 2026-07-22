{
  osConfig,
  config,
  lib,
  ...
}:
let
  cfg = config.program.foliate;
in
{
  options.program.foliate = {
    enable = lib.mkEnableOption "Enable default Foliate settings";
  };

  config = lib.mkIf cfg.enable {
    theme.matugen.templates.foliate = {
      input_path = ../theme/templates/foliate.json;
      output_path = "${config.xdg.configHome}/com.github.johnfactotum.Foliate/themes/matugen.json";
    };

    programs.foliate = {
      enable = true;
      settings = {
        "viewer/font" = {
          default-size = osConfig.theme.fonts.sizes.applications;
        };
        "viewer/view" = {
          theme = "matugen.json";
        };
      };
    };
  };
}

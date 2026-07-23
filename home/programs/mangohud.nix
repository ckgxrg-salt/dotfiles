{
  osConfig,
  config,
  lib,
  ...
}:
let
  cfg = config.program.mangohud;
in
{
  options.program.mangohud = {
    enable = lib.mkEnableOption "Enable mangohud game HUD";
  };

  config = lib.mkIf cfg.enable {
    # TODO: Matugen

    programs.mangohud = {
      enable = true;
      settings = {
        vsync = 0;
        gamemode = true;
        font_size = osConfig.theme.fonts.sizes.applications;
        font_size_text = osConfig.theme.fonts.sizes.applications;
      };
    };
  };
}

{
  config,
  osConfig,
  lib,
  ...
}:
with lib;
let
  cfg = osConfig.theme.cursor;
in
{
  config = {
    home.packages = mkIf (cfg.package != null) [ cfg.package ];

    home.sessionVariables = {
      XCURSOR_SIZE = cfg.size;
      XCURSOR_THEME = cfg.name;

      HYPRCURSOR_THEME = cfg.name;
      HYPRCURSOR_SIZE = cfg.size;
    };

    home.sessionSearchVariables.XCURSOR_PATH = [ "${config.home.profileDirectory}/share/icons" ];
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.boot.splash;
in
{
  options.boot.splash = mkOption {
    type = types.nullOr types.str;
    default = null;
    description = "Theme name from adi1090x's theme collection";
  };

  config = mkIf (cfg != null) {
    boot.plymouth = {
      enable = true;
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ cfg ];
        })
      ];
      theme = cfg;
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.boot.splash;
in
{
  options.boot.splash = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "Theme name from adi1090x's theme collection";
  };

  config = lib.mkIf (cfg != null) {
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

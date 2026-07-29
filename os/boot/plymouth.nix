{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.boot.splash = lib.mkOption {
    type = lib.types.nullOr lib.types.str;
    default = null;
    description = "Theme name from adi1090x's theme collection";
  };

  config = {
    boot.plymouth = {
      enable = true;
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.override {
          selected_themes = [ config.boot.splash ];
        })
      ];
      theme = config.boot.splash;
    };
  };
}

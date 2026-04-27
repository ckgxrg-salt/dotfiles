{
  config,
  lib,
  pkgs,
  ...
}:
# Wallpaper daemons
with lib;
let
  cfg = config.theme.wallpaper;
  iniFormat = pkgs.formats.ini { };
in
{
  options.theme.wallpaper = {
    awww = {
      enable = mkEnableOption "Enable awww, a lightweight wallpaper daemon.";
    };

    waypaper = {
      enable = mkEnableOption "Enable Waypaper, frontend for wallpaper daemons.";
      package = mkOption {
        type = types.package;
        description = "The Waypaper package to use.";
        default = pkgs.waypaper;
      };
      settings = mkOption {
        type = iniFormat.type;
        description = "Default settings passed to Waypaper.";
        default = { };
      };
    };
  };

  config = {
    home.packages = lists.optional cfg.waypaper.enable cfg.waypaper.package;

    services.awww = mkIf cfg.awww.enable {
      enable = true;
    };

    # Waypaper
    xdg.configFile = mkIf cfg.waypaper.enable {
      "waypaper/config.ini".source = (iniFormat.generate "waypaper.ini" cfg.waypaper.settings);
    };
  };
}

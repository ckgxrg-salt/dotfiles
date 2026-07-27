{
  config,
  lib,
  pkgs,
  ...
}:
# Wallpaper daemons
let
  cfg = config.theme.wallpaper;
  iniFormat = pkgs.formats.ini { };
in
{
  options.theme.wallpaper = {
    awww = {
      enable = lib.mkEnableOption "Enable awww, a lightweight wallpaper daemon.";
    };

    waypaper = {
      enable = lib.mkEnableOption "Enable Waypaper, frontend for wallpaper daemons.";
      package = lib.mkOption {
        type = lib.types.package;
        description = "The Waypaper package to use.";
        default = pkgs.waypaper;
      };
      settings = lib.mkOption {
        type = iniFormat.type;
        description = "Default settings passed to Waypaper.";
        default = { };
      };
    };
  };

  config = {
    home.packages = lib.lists.optional cfg.waypaper.enable cfg.waypaper.package;

    services.awww = lib.mkIf cfg.awww.enable {
      enable = true;
    };

    # Waypaper
    xdg.configFile = lib.mkIf cfg.waypaper.enable {
      "waypaper/config.ini".source = (iniFormat.generate "waypaper.ini" cfg.waypaper.settings);
    };
  };
}

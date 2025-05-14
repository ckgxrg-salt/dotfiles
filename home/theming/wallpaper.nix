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
    # A Solution to your Wayland Wallpaper Woes
    swww-daemon = {
      enable = mkEnableOption "Enable swww, a lightweight wallpaper daemon.";
      package = mkOption {
        type = types.package;
        description = "The swww package to use.";
        default = pkgs.swww;
      };
    };

    # Waypaper, frontend for many wallpaper daemons
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
    home.packages =
      lists.optional cfg.swww-daemon.enable cfg.swww-daemon.package
      ++ lists.optional cfg.waypaper.enable cfg.waypaper.package;

    systemd.user.services."swww-daemon" = mkIf cfg.swww-daemon.enable {
      Unit = {
        Description = "A Solution to your Wayland Wallpaper Woes";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "exec";
        ExecStart = "${cfg.swww-daemon.package}/bin/swww-daemon";
        Restart = "on-failure";
        Slice = "background-graphical.slice";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    # Waypaper
    xdg.configFile = mkIf cfg.waypaper.enable {
      "waypaper/config.ini".source = (iniFormat.generate "waypaper.ini" cfg.waypaper.settings);
    };
  };
}

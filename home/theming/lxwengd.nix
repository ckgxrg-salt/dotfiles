{
  config,
  lib,
  pkgs,
  ...
}:
# LxWEngD
with lib;
let
  cfg = config.theme.wallpaper.lxwengd;
in
{
  options.theme.wallpaper.lxwengd = {
    enable = mkEnableOption "Enable LxWEngD, a wrapper over linux-wallpaperengine providing playlist support.";
    package = mkOption {
      type = types.package;
      description = "The LxWEngD package to use.";
    };
    enginePackage = mkOption {
      type = types.package;
      description = "The linux-wallpaperengine package to use.";
      default = pkgs.linux-wallpaperengine;
    };
    assetsPath = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Path to the assets directory if not the default.";
    };
    defaultPlaylist = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Path to the default playlist LxWEngD will use upon start.";
    };
  };

  config = mkIf cfg.enable {
    # Install the package
    home.packages = [
      cfg.package
      cfg.enginePackage
    ];

    # Run the program
    systemd.user.services."lxwengd" =
      let
        args = cli.toGNUCommandLine { } {
          assets-path = cfg.assetsPath;
          playlist = cfg.defaultPlaylist;
        };
      in
      {
        Unit = {
          Description = "Wrapper daemon of linux-wallpaperengine";
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "exec";
          ExecStart = "${cfg.package}/bin/lxwengd " + (strings.concatStringsSep " " args);
          Restart = "on-failure";
          Slice = "background-graphical.slice";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };

  };
}

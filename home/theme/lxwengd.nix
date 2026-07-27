{
  config,
  lib,
  pkgs,
  ...
}:
# LxWEngD
let
  cfg = config.theme.wallpaper.lxwengd;
in
{
  options.theme.wallpaper.lxwengd = {
    enable = lib.mkEnableOption "Enable LxWEngD, a wrapper over linux-wallpaperengine providing playlist support.";
    package = lib.mkOption {
      type = lib.types.package;
      description = "The LxWEngD package to use.";
    };
    enginePackage = lib.mkOption {
      type = lib.types.package;
      description = "The linux-wallpaperengine package to use.";
      default = pkgs.linux-wallpaperengine;
    };
    assetsPath = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Path to the assets directory if not the default.";
    };
    defaultPlaylist = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Path to the default playlist LxWEngD will use upon start.";
    };
  };

  config = lib.mkIf cfg.enable {
    # Install the package
    home.packages = [
      cfg.package
      cfg.enginePackage
    ];

    # Run the program
    systemd.user.services."lxwengd" =
      let
        args = lib.cli.toGNUCommandLine { } {
          assets-path = cfg.assetsPath;
          playlist = cfg.defaultPlaylist;
        };
      in
      {
        Unit = {
          Description = "Wrapper daemon of linux-wallpaperengine";
          PartOf = [ "graphical-session.target" ];
        };
        Service = {
          Type = "exec";
          ExecStart = "${cfg.package}/bin/lxwengd " + (lib.strings.concatStringsSep " " args);
          Restart = "on-failure";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };

  };
}

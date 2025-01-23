{
  config,
  lib,
  pkgs,
  ...
}:
# Linux Wallpaperengine
with lib;
let
  cfg = config.ckgxrg.theme.wallpaper.linux-wallpaperengine;
in
{
  options.ckgxrg.theme.wallpaper.linux-wallpaperengine = {
    enable = mkEnableOption "Whether to enable linux-wallpaperengine, an implementation of Wallpaper Engine functionality on Linux";
    package = mkOption {
      type = types.package;
      description = "The linux-wallpaperengine package to use";
      default = pkgs.linux-wallpaperengine;
    };
    assetsPath = mkOption {
      type = types.str;
      default = "${config.xdg.dataHome}/Steam/steamapps/common/wallpaper_engine/assets";
      description = "Path to the assets directory if not the default";
    };
    clamping = mkOption {
      type = types.enum [
        "clamp"
        "border"
        "repeat"
      ];
      default = "clamp";
      description = "Clamping mode for all wallpapers";
    };
    wallpapers = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            monitor = mkOption {
              type = types.str;
              description = "Which monitor to show the wallpaper";
            };
            wallpaperId = mkOption {
              type = types.str;
              description = "Wallpaper ID to be used";
            };
            wallpaperIdEnv = mkOption {
              type = types.str;
              description = "Environment variable storing a wallpaper ID, may be used to dynamically change the wallpaper without rebuilding the system, intended to be used with LWPEHelper";
            };
            scaling = mkOption {
              type = types.enum [
                "stretch"
                "fit"
                "fill"
                "default"
              ];
              default = "default";
              description = "Scaling mode for this wallpaper";
            };
            audio = {
              silent = mkOption {
                type = types.bool;
                default = false;
                description = "Mutes all sound of the wallpaper";
              };
              automute = mkOption {
                type = types.bool;
                default = true;
                description = "Automute when another app is playing sound";
              };
              audio-processing = mkOption {
                type = types.bool;
                default = true;
                description = "Enables audio processing for background";
              };
              volume = mkOption {
                type = types.nullOr types.float;
                default = null;
                description = "Sets the volume of the background";
              };
            };
          };
        }
      );
      default = [ ];
      description = "Wallpapers to define";
    };
  };

  config = mkIf cfg.enable {
    # Run the program
    systemd.user.services."linux-wallpaperengine" =
      let
        args = lists.forEach cfg.wallpapers (
          each:
          concatStringsSep " " (
            cli.toGNUCommandLine { } {
              screen-root = each.monitor;
              inherit (each) scaling;
              silent = each.audio.silent;
              noautomute = !each.audio.automute;
              no-audio-processing = !each.audio.audio-processing;
              volume = each.audio.volume;
            }
          )
          # This has to be the last argument in each group
          + " --bg ${each.wallpaperId}"
        );
      in
      {
        Unit = {
          Description = "Implementation of Wallpaper Engine on Linux";
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "exec";
          ExecStart =
            "${cfg.package}/bin/linux-wallpaperengine "
            + "--assets-dir ${cfg.assetsPath} "
            + "--clamping ${cfg.clamping} "
            + (strings.concatStringsSep " " args);
          Restart = "on-failure";
          Slice = "background-graphical.slice";
        };
        Install = {
          WantedBy = [ "graphical-session.target" ];
        };
      };
  };
}

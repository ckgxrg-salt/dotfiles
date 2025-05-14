{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.apps.kodi;
in
{
  options.apps.kodi = mkEnableOption "Enable Kodi home media centre";

  config = mkIf cfg {
    programs.kodi = {
      enable = true;
      package = pkgs.kodi-wayland;
      datadir = "${config.xdg.dataHome}/kodi";
      sources = {
        video = {
          default = "Videos";
          source = [
            {
              name = "Videos";
              path = "${config.xdg.userDirs.videos}";
              allowsharing = "true";
            }
          ];
        };
        music = {
          default = "Music";
          source = [
            {
              name = "Music";
              path = "${config.xdg.userDirs.music}";
              allowsharing = "true";
            }
          ];
        };
      };
    };
  };
}

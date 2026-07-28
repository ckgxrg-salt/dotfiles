{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.desktop.xdg;
in
{
  options.desktop.xdg = {
    default = lib.mkEnableOption "Enable default XDG settings";
  };

  config = lib.mkIf cfg.default {
    xdg = {
      enable = true;
      mime.enable = true;

      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
        config = {
          common = {
            default = [
              "gtk"
              "gnome"
            ];
          };
        };
      };

      userDirs = {
        enable = true;
        createDirectories = true;
        setSessionVariables = false;
      };
    };
  };
}

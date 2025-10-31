{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.desktop.xdg;
in
{
  options.desktop.xdg = mkEnableOption "Enable default XDG settings";

  config = mkIf cfg {
    # XDG config
    xdg = {
      enable = true;
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "text/plain" = "nvim.desktop";
          "application/pdf" = "org.kde.okular.desktop";
          "image/jpeg" = "pix.desktop";
          "image/png" = "pix.desktop";
          "inode/directory" = "org.gnome.Nautilus.desktop";
          "text/html" = "floorp.desktop";
          "x-scheme-handler/http" = "floorp.desktop";
          "x-scheme-handler/https" = "floorp.desktop";
          "x-scheme-handler/about" = "floorp.desktop";
          "x-scheme-handler/unknown" = "floorp.desktop";
        };
      };

      # Portals
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-hyprland
        ];
        config = {
          common = {
            default = [ "gtk" ];
          };
          hyprland = {
            default = [
              "hyprland"
              "gtk"
            ];
            "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
          };
        };
      };

      # XDG User Dirs
      userDirs = {
        enable = true;
        createDirectories = true;
      };
    };
  };
}

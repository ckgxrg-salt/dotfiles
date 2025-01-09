{ pkgs, ... }:
{
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
        "inode/directory" = "org.kde.index.desktop";
        "text/html" = "qutebrowser.desktop";
        "x-scheme-handler/http" = "qutebrowser.desktop";
        "x-scheme-handler/https" = "qutebrowser.desktop";
        "x-scheme-handler/about" = "qutebrowser.desktop";
        "x-scheme-handler/unknown" = "qutebrowser.desktop";
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
          "org.freedesktop.impl.portal.Secret" = [ "pass-secret-service" ];
        };
      };
    };

    # XDG User Dirs
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    # Override some desktop entries
    desktopEntries = {
      # Fix Electron IME
      "obsidian" = {
        name = "Obsidian";
        icon = "obsidian";
        comment = "Knowledge base";
        exec = "obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime";
        type = "Application";
        mimeType = [ "x-scheme-handler/obsidian" ];
        categories = [ "Office" ];
        settings = {
          Version = "1.4";
        };
      };
      "qq" = {
        name = "QQ";
        icon = "${pkgs.qq}/share/icons/hicolor/512x512/apps/qq.png";
        comment = "QQ";
        terminal = false;
        exec = "/run/current-system/sw/bin/qq --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime";
        type = "Application";
        categories = [ "Network" ];
        settings = {
          StartupWMClass = "QQ";
        };
      };

      # There's some issues about kvantum style
      "nheko" = {
        name = "nheko";
        comment = "Desktop client for Matrix";
        exec = "env QT_STYLE_OVERRIDE= nheko %u";
        icon = "nheko";
        type = "Application";
        categories = [
          "Network"
          "InstantMessaging"
          "Qt"
        ];
        terminal = false;
        mimeType = [ "x-scheme-handler/matrix" ];
        settings = {
          Version = "1.0";
          StartupWMClass = "nheko";
        };
      };
    };
  };
}

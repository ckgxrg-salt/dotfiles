{ config, pkgs, ... }:
# Define theme names and pkgs here
let
  gtkTheme = "Nightfox-Dusk-B";
  gtkPkg = pkgs.nightfox-gtk-theme;

  qtStyle = "MateriaDark";
  qtPkg = pkgs.materia-kde-theme;

  cursor = "Afterglow-Recolored-Dracula-Cyan";
  cursorPkg = pkgs.afterglow-cursors-recolored;

  icon = "Tela-blue-dark";
  iconPkg = pkgs.tela-icon-theme;

  customFont = "Maple Mono";
in {
  # GTK Look and Feel
  gtk = {
    enable = true;
    theme = {
      name = gtkTheme;
      package = gtkPkg;
    };
    cursorTheme = {
      name = cursor;
      package = cursorPkg;
    };
    font = {
      name = customFont;
      size = 12;
    };
    iconTheme = {
      name = icon;
      package = iconPkg;
    };
  };

  # Qt Style
  home.packages = with pkgs; [
    kdePackages.qtbase
    kdePackages.qttools
    kdePackages.qtwayland
    kdePackages.qtwebengine
    kdePackages.qtquick3d
    kdePackages.qt5compat
    kdePackages.qtsvg
    kdePackages.qt6gtk2
    libsForQt5.qt5.qtbase
    libsForQt5.qt5.qtquickcontrols
    libsForQt5.qt5.qtgraphicaleffects
    hyprcursor
  ];
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };
  xdg.configFile = {
  "Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=${qtStyle}
  '';

  "Kvantum/${qtStyle}".source = "${qtPkg}/share/Kvantum/${qtStyle}";
  };

  # Hyprland Managed Cursor
  wayland.windowManager.hyprland.extraConfig = ''
    env = HYPRCURSOR_THEME,${cursor}
    env = HYPRCURSOR_SIZE,24
    env = XCURSOR_THEME,${cursor}
    env = XCURSOR_SIZE,24
  '';

  home.activation = {
    fixFlatpakThemes = ''
      run ln -sfT ${iconPkg}/share/icons/${icon} /home/ckgxrg/.icons/${icon}
      run ln -sfT ${cursorPkg}/share/icons/${cursor} /home/ckgxrg/.icons/${cursor}
      run ln -sfT ${gtkPkg}/share/themes/${gtkTheme} /home/ckgxrg/.themes/${gtkTheme}
    '';
  };

  # Then make them availiable to Flatpaks
  services.flatpak.overrides = {
    global = {
      # Force Wayland
      Context.sockets = [
        "wayland"
        "!x11"
        "fallback-x11"
      ];
      # Make files accessible to flatpaks
      Context.filesystems = [
        "/home/ckgxrg/.themes:ro"
        "/home/ckgxrg/.icons:ro"
        "${gtkPkg}/share/themes:ro"
        "${iconPkg}/share/icons:ro"
        "${cursorPkg}/share/icons:ro"
        "xdg-config/Kvantum:ro"
      ];
      # Set themes
      Environment = {
        "GTK_THEME" = gtkTheme;
        "ICON_THEME"= icon;
        "QT_STYLE_OVERRIDE" = "kvantum";
        "HYPRCURSOR_THEME" = cursor;
        "HYPRCURSOR_SIZE" = "24";
        "XCURSOR_PATH" = "${cursorPkg}/share/icons";
        "XCURSOR_THEME" = cursor;
        "XCURSOR_SIZE" = "24";
      };
    };
  };
}